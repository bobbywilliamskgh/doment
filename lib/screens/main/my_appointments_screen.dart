import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/appointments.dart';

class MyAppointmentsScreen extends StatefulWidget {
  static const routeName = 'my-appointments';
  @override
  _MyAppointmentsScreenState createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          elevation: 2,
          centerTitle: true,
          title: const Text(
            'My appointments',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          bottom: TabBar(
            tabs: [
              const Tab(
                text: 'Upcoming',
              ),
              const Tab(
                text: 'History',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: Provider.of<Appointments>(context, listen: false)
                  .fetchAndSetAppointments('timeUploaded'),
              builder: (ctx, snapshot) {
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
                        child: const Text('No upcoming appointments'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: app.appointments.length,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(16),
                            height: 200,
                            width: double.infinity,
                            color: Colors.blueGrey[100],
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Date',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('d MMM yyyy')
                                                        .format(app
                                                            .appointments[index]
                                                            .date),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Time',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('hh:mm').format(
                                                        app.appointments[index]
                                                            .date),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Doctor',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    app.appointments[index]
                                                        .doctor['name'],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Speciality',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    app.appointments[index]
                                                        .doctor['type'],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      RaisedButton(
                                        onPressed: () {},
                                        child: const Text('Edit'),
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      RaisedButton(
                                        shape: Border.all(
                                          color: Theme.of(context).accentColor,
                                          width: 1,
                                        ),
                                        onPressed: () {},
                                        child: const Text('Cancel'),
                                        textColor:
                                            Theme.of(context).accentColor,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
            Center(
              child: const Text('No history found'),
            )
          ],
        ),
      ),
    );
  }
}
