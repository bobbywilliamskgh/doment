import 'package:flutter/material.dart';
import './appointment_details_screen.dart';

class SuccessfulBookingScreen extends StatelessWidget {
  static const routeName = '/successful-booking';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(
            context, AppointmentDetailsScreen.routeName);
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.lightBlue[900],
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 100),
                        child: Image.asset('assets/images/like.png'),
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      const Text(
                        'Appointment booked',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'successfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Your appointment is confirmed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.all(10),
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        AppointmentDetailsScreen.routeName);
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
