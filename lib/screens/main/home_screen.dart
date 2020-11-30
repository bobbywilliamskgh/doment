import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:doctor_appointment/widgets/home/next_appointment.dart';
import 'package:doctor_appointment/widgets/home/doctors_you_have_visited.dart';
import 'package:doctor_appointment/widgets/home/prescriptions.dart';
import 'package:doctor_appointment/widgets/home/test_results.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInternetConnected = true;

  Future<void> _initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetConnected = false;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occured. Please check your internet connection !',
          ),
          backgroundColor: Theme.of(context).errorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser.uid;
    return !_isInternetConnected
        ? Container()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .snapshots(),
                      builder: (ctx, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello ${userSnapshot.data['firstName']},',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Text(
                              'How are you today ?',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  NextAppointment(),
                  const SizedBox(
                    height: 16,
                  ),
                  DoctorsYouHaveVisited(),
                  const SizedBox(
                    height: 16,
                  ),
                  Prescriptions(),
                  const SizedBox(
                    height: 16,
                  ),
                  TestResults(),
                ],
              ),
            ),
          );
  }
}
