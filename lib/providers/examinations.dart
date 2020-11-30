import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/examination.dart';
import '../helpers/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Examinations with ChangeNotifier {
  List<Examination> _examinations = [];

  List<Examination> get examinations {
    return [..._examinations];
  }

  Future<void> fetchAndSetExaminations() async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final querySnapshot = await DBHelper.getDataFromCollections(
        colRef1: 'users',
        doc: userId,
        colRef2: 'examinations',
      );
      final docs = querySnapshot.docs;
      List<Examination> loadedTestResults = [];
      docs.forEach((doc) {
        final data = doc.data();
        final dt = (data['date'] as Timestamp).toDate();
        loadedTestResults.add(
          Examination(
            id: data['id'],
            date: dt,
            title: data['title'],
          ),
        );
      });
      _examinations = loadedTestResults;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
