import 'package:doctor_appointment/models/patient.dart';
import 'package:doctor_appointment/providers/doctors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:doctor_appointment/helpers/time_helper.dart';
import 'package:doctor_appointment/providers/doctor.dart';
import 'package:doctor_appointment/widgets/newAppointment/patient_form.dart';
import 'package:doctor_appointment/providers/appointments.dart';
import './successful_booking_screen.dart';

class PatientDetailsScreen extends StatelessWidget {
  static const routeName = '/patient-details';
  @override
  Widget build(BuildContext context) {
    final chosenSlot =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Patient Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: PatientDetailsContent(chosenSlot),
    );
  }
}

class PatientDetailsContent extends StatefulWidget {
  final Map<String, dynamic> chosenSlot;

  PatientDetailsContent(this.chosenSlot);

  @override
  _PatientDetailsContentState createState() => _PatientDetailsContentState();
}

class _PatientDetailsContentState extends State<PatientDetailsContent> {
  final FormController formController = FormController();
  var _isLoading = false;
  DateTime _dt;
  Doctor _doctor;

  Future<void> _confirmForm(Map<String, String> patientData) async {
    setState(() {
      _isLoading = true;
    });
    final patient = Patient(
      patientData['name'],
      patientData['phoneNumber'],
      patientData['email'],
    );
    try {
      Provider.of<Doctors>(context, listen: false)
          .addDoctorsThatUserHaveVisited(_doctor);
      await Provider.of<Appointments>(context, listen: false)
          .addNewAppointment(patient, _doctor, 'Consultation', _dt);
      Navigator.of(context).pushNamedAndRemoveUntil(
          SuccessfulBookingScreen.routeName, ModalRoute.withName('/'));
    } catch (error) {
      print(error);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred! Try again later.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      print('error....');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.chosenSlot['doctor'] as Doctor;
    final dt = widget.chosenSlot['chosenDate'] as DateTime;
    _doctor = doctor;
    _dt = dt;
    final day = TimeHelper.convertDayToTerm(dt);
    final hourMinute = DateFormat.jm().format(dt);

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doctor.imageUrl),
                        ),
                        title: Text(
                          doctor.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text(doctor.type),
                      ),
                      Divider(),
                      ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Purpose of visit',
                            ),
                            Expanded(
                              child: Text(
                                'Consultation',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date and time',
                            ),
                            Expanded(
                              child: Text(
                                '$day, $hourMinute',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PatientForm(formController, _confirmForm),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: const Text(
                                'By Booking this appointment you agree to the ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            FittedBox(
                              child: const Text(
                                'T&C',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                        color: Colors.grey[350],
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    formController.save();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  elevation: 0,
                  color: Theme.of(context).accentColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
            ],
          );
  }
}
