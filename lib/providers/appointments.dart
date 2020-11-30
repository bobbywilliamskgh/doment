import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/appointment.dart';
import '../helpers/db_helper.dart';
import '../models/patient.dart';
import './doctor.dart';

class Appointments with ChangeNotifier {
  List<Appointment> _appointments = [];
  Appointment _newAppointment;

  List<Appointment> get appointments {
    return [..._appointments];
  }

  Appointment get newAppointment {
    return _newAppointment;
  }

  Future<void> fetchAndSetAppointments(String filteringField) async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    QuerySnapshot querySnapshot;
    try {
      if (filteringField == 'timeUploaded') {
        querySnapshot = await DBHelper.getDataFromCollections(
          colRef1: 'appointments',
          doc: userId,
          colRef2: 'userAppointments',
          filtering: true,
          filteringField: 'timeUploaded',
        );
      }
      if (filteringField == 'date') {
        querySnapshot = await DBHelper.getDataFromCollections(
          colRef1: 'appointments',
          doc: userId,
          colRef2: 'userAppointments',
          filtering: true,
          filteringField: 'date',
        );
      }

      final docs = querySnapshot.docs;
      List<Appointment> loadedAppointments = [];
      docs.forEach((app) {
        final dataMap = app.data();
        final dateTimeStamp = dataMap['date'] as Timestamp;
        final dt = dateTimeStamp.toDate();

        loadedAppointments.add(
          Appointment(
            id: app.id,
            date: dt,
            doctor: dataMap['doctor'],
          ),
        );
      });

      _appointments = loadedAppointments;

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addNewAppointment(
    Patient patient,
    Doctor doctor,
    String purpose,
    DateTime date,
  ) async {
    try {
      var now = DateTime.now();
      final userId = FirebaseAuth.instance.currentUser.uid;
      final docRef = await DBHelper.addData(
          colRef1: 'appointments',
          id: userId,
          colRef2: 'userAppointments',
          data: {
            'doctor': {
              'name': doctor.name,
              'imageUrl': doctor.imageUrl,
              'type': doctor.type,
              'location': {
                'placeName': doctor.location['placeName'],
                'address': doctor.location['address'],
              },
            },
            'patient': {
              'name': patient.name,
              'phoneNumber': patient.phoneNumber,
              'email': patient.email,
            },
            'purpose': purpose,
            'date': Timestamp.fromDate(date),
            'timeUploaded': now,
          });
      final docSnapshot = await docRef.get();
      final docId = docSnapshot.id;
      final data = docSnapshot.data();
      final dateTimeStamp = data['date'] as Timestamp;
      final uploadedDateTimeStamp = data['timeUploaded'] as Timestamp;
      final dt = dateTimeStamp.toDate();
      final timeUploaded = uploadedDateTimeStamp.toDate();
      final newAppointment = Appointment(
        id: docId,
        doctor: data['doctor'],
        patient: Patient(
          data['patient']['name'],
          data['patient']['phoneNumber'],
          data['patient']['email'],
        ),
        purpose: data['purpose'],
        date: dt,
        timeUploaded: timeUploaded,
      );
      _newAppointment = newAppointment;
      _appointments.add(newAppointment);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
