import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser with ChangeNotifier {
  String _firstName;
  String _lastName;
  String _email;

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  String get email {
    return _email;
  }

  Future<void> fetchAndSetUserData() async {
    final userId = FirebaseAuth.instance.currentUser.uid;
    final docData =
        await DBHelper.getDataFromSpesificDoc(colRef1: 'users', doc1: userId);
    final data = docData.data();
    _firstName = data['firstName'];
    _lastName = data['lastName'];
    _email = data['email'];
    notifyListeners();
  }
}
