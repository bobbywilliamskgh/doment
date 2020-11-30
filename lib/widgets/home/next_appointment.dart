import 'package:doctor_appointment/helpers/time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:doctor_appointment/providers/appointments.dart';

class NextAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widthDeviceMinusPadding = MediaQuery.of(context).size.width - 40;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Next appointment',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder(
          future: Provider.of<Appointments>(context, listen: false)
              .fetchAndSetAppointments('timeUploaded'),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dataSnapshot.hasError) {
              // Show error info
            }
            return Consumer<Appointments>(
              builder: (_, appointmetnsData, child) {
                if (appointmetnsData.appointments.length == 0) {
                  print('appointments length = 0');
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Appointment yet',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 180,
                    child: ListView.builder(
                      itemCount: appointmetnsData.appointments.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        var dt = appointmetnsData.appointments[index].date;
                        var day = TimeHelper.convertDayToTerm(dt);
                        var dateFormatted =
                            DateFormat('d MMM yyyy, h:mm a').format(dt);
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: widthDeviceMinusPadding,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        day,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        dateFormatted,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    color: Theme.of(context).primaryColor,
                                    icon: Icon(Icons.map),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Container(
                                width: double.infinity,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      appointmetnsData.appointments[index]
                                          .doctor['imageUrl'],
                                    ),
                                  ),
                                  title: Text(
                                    appointmetnsData
                                        .appointments[index].doctor['name'],
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  subtitle: Text(
                                    appointmetnsData
                                        .appointments[index].doctor['type'],
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          },
        )
      ],
    );
  }
}
