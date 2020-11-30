import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './doctor.dart';
import '../helpers/db_helper.dart';

class Doctors with ChangeNotifier {
  List<Doctor> _items = [];
  List<Doctor> _doctorsUserHaveVisited = [];

  List<Doctor> get items {
    return [..._items];
  }

  List<Doctor> get doctorsUserHaveVisited {
    return [..._doctorsUserHaveVisited];
  }

  List<Doctor> filterByHcId(String hcId) {
    var filteredDoctors =
        _items.where((doctor) => doctor.healthConcern == hcId).toList();
    return filteredDoctors;
  }

  Doctor findById(String doctorId) {
    var doctorById = _items.firstWhere((doctor) => doctor.id == doctorId);
    return doctorById;
  }

  Future<void> fetchAndSetDoctors() async {
    try {
      final data = await DBHelper.getDataFromCollections(colRef1: 'doctors');
      final documents = data.docs;
      _items = documents.map((doc) {
        var docId = doc.id;
        var docData = doc.data();
        var availabilityFromFireStore =
            Map<String, dynamic>.from(docData['availability']);
        var availability = availabilityFromFireStore.map((key, value) => MapEntry(
            key,
            List<Timestamp>.from(
                value))); // Create new map and cast the value to List<Timestamp> of map from firestore
        var locationFromFireStore =
            Map<String, dynamic>.from(docData['location']);
        var location = locationFromFireStore
            .map((key, value) => MapEntry(key, value as String));

        return Doctor(
          id: docId,
          name: docData['name'],
          gender: docData['gender'],
          healthConcern: docData['healthConcern'],
          type: docData['type'],
          imageUrl: docData['imageUrl'],
          feeStart: docData['feeStart'],
          rate: double.parse('${docData['rate']}'),
          availablity: availability,
          location: location,
        );
      }).toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addDoctorsThatUserHaveVisited(Doctor doctor) async {
    // Upload to user collections -> spesicic userId -> doctors collection -> with doctorId
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      await DBHelper.setData(
          colRef1: 'users',
          id1: userId,
          colRef2: 'doctors',
          id2: doctor.id,
          data: {
            'availability': doctor.availablity,
            'feeStart': doctor.feeStart,
            'gender': doctor.gender,
            'healthConcern': doctor.healthConcern,
            'imageUrl': doctor.imageUrl,
            'location': doctor.location,
            'name': doctor.name,
            'rate': doctor.rate,
            'type': doctor.type,
          });
      final newDoctor = Doctor(
        id: doctor.id,
        name: doctor.name,
        type: doctor.type,
        imageUrl: doctor.imageUrl,
        gender: doctor.gender,
        healthConcern: doctor.healthConcern,
        feeStart: doctor.feeStart,
        rate: doctor.rate,
        availablity: doctor.availablity,
        location: doctor.location,
      );
      _doctorsUserHaveVisited.add(newDoctor);
      notifyListeners();
    } catch (error) {
      print('error in addDoctorsThatUserHaveVisited $error');
      throw error;
    }
  }

  Future<void> fetchAndSetDoctorsThatUserHaveVisited() async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final querySnapshot = await DBHelper.getDataFromCollections(
          colRef1: 'users', doc: userId, colRef2: 'doctors');
      final docs = querySnapshot.docs;
      List<Doctor> loadedDoctors = [];
      docs.forEach((doc) {
        final data = doc.data();
        final availabilityFromFireStore =
            Map<String, dynamic>.from(data['availability']);
        final availability = availabilityFromFireStore.map(
          (key, value) => MapEntry(
            key,
            List<Timestamp>.from(value),
          ),
        );
        final locationFromFireStore =
            Map<String, dynamic>.from(data['location']);
        final location = locationFromFireStore
            .map((key, value) => MapEntry(key, value as String));
        loadedDoctors.add(
          Doctor(
            id: data['id'],
            name: data['name'],
            type: data['type'],
            imageUrl: data['imageUrl'],
            gender: data['gender'],
            healthConcern: data['healthConcern'],
            feeStart: data['feeStart'],
            rate: data['rate'],
            availablity: availability,
            location: location,
          ),
        );
      });
      _doctorsUserHaveVisited = loadedDoctors;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
