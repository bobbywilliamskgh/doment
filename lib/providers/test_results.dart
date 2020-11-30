import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/test_result.dart';
import '../helpers/db_helper.dart';

class TestResults with ChangeNotifier {
  List<TestResult> _testResults = [];

  List<TestResult> get testResults {
    return [..._testResults];
  }

  Future<void> fetchAndSetTestResults() async {
    try {
      final userId = FirebaseAuth.instance.currentUser.uid;
      final querySnapshot = await DBHelper.getDataFromCollections(
        colRef1: 'users',
        doc: userId,
        colRef2: 'testResults',
      );
      final docs = querySnapshot.docs;
      List<TestResult> loadedTestResults = [];
      docs.forEach((doc) {
        final data = doc.data();
        final dt = (data['date'] as Timestamp).toDate();
        loadedTestResults.add(
          TestResult(
            id: doc.id,
            title: data['title'],
            date: dt,
          ),
        );
      });
      _testResults = loadedTestResults;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
