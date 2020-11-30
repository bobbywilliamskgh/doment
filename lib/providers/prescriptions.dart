import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/prescription.dart';
import 'package:doctor_appointment/helpers/db_helper.dart';

class Prescriptions with ChangeNotifier {
  List<Prescription> _prescriptions = [];

  List<Prescription> get prescriptions {
    return [..._prescriptions];
  }

  Future<void> fetchAndSetPrescriptions() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final querySnapshot = await DBHelper.getDataFromCollections(
        colRef1: 'users',
        doc: user.uid,
        colRef2: 'prescriptions',
      );
      final docs = querySnapshot.docs;
      List<Prescription> loadedPrescriptions = [];
      docs.forEach((doc) {
        final data = doc.data();
        final dt = (data['dateGiven'] as Timestamp).toDate();
        final recipes = List<Map<String, dynamic>>.from(data['recipes']);

        loadedPrescriptions.add(
          Prescription(
            id: doc.id,
            dateGiven: dt,
            givenBy: data['givenBy'],
            prescriptionName: data['prescriptionName'],
            recipes: recipes,
          ),
        );
      });
      _prescriptions = loadedPrescriptions;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
