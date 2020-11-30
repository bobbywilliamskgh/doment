import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:doctor_appointment/providers/appointments.dart';

class Visit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Appointments>(context, listen: false)
          .fetchAndSetAppointments('date'),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // show error info
        }
        return Consumer<Appointments>(
          builder: (_, app, ch) {
            if (app.appointments.isEmpty) {
              return Center(
                child: const Text('No Visit'),
              );
            } else {
              return ListView.builder(
                itemCount: app.appointments.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    height: 170,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMM d')
                                  .format(app.appointments[index].date)
                                  .toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('EEE. hh:mm')
                                  .format(app.appointments[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(4),
                                color: Colors.blueGrey[100]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 40,
                                  child: Image.network(
                                    app.appointments[index].doctor['imageUrl'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      app.appointments[index].doctor['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                        app.appointments[index].doctor['type']),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    InkWell(
                                      child: Text(
                                        'See Full Reports',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
