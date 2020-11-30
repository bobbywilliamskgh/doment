import 'package:doctor_appointment/helpers/time_helper.dart';
import 'package:doctor_appointment/providers/appointments.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  static const routeName = '/appointment-detail';
  @override
  Widget build(BuildContext context) {
    final appointment = Provider.of<Appointments>(context).newAppointment;
    print(appointment);
    final doctor = appointment.doctor;
    final dt = appointment.date;
    var dtFormatted =
        '${TimeHelper.convertDayToTerm(dt)}, ${DateFormat.jm().format(dt)}';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'Appointment details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(doctor['imageUrl']),
            ),
            title: Text(doctor['name']),
            subtitle: Text(doctor['type']),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Date and time',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  dtFormatted,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'In ${TimeHelper.duration(dt, 'hour')} hours',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Practice detail',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  doctor['location']['placeName'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  doctor['location']['address'],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                FlatButton(
                  padding: const EdgeInsets.all(0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {},
                  child: Text(
                    'GET DIRECTIONS',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Procedure',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  appointment.purpose,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Booked for',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          appointment.patient.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Appointments ID',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(
                            appointment.id,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[350],
              padding: const EdgeInsets.only(
                left: 10,
                top: 16,
                right: 16,
                bottom: 16,
              ),
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Manage your appointments better by visiting ',
                    ),
                    TextSpan(
                      text: 'My appointments',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('my appointments link');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              elevation: 0,
              color: Theme.of(context).accentColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
