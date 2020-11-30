import 'package:doctor_appointment/providers/doctors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorsYouHaveVisited extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Doctors you have visited',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: const Text('See All'),
              textColor: Theme.of(context).accentColor,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder(
          future: Provider.of<Doctors>(context, listen: false)
              .fetchAndSetDoctorsThatUserHaveVisited(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dataSnapshot.hasError) {
              // show error info to user
            }
            return Consumer<Doctors>(
              builder: (_, doctorsData, ch) {
                if (doctorsData.doctorsUserHaveVisited.length == 0) {
                  return Card(
                    child: Container(
                      height: 100,
                      child: Center(
                        child: const Text(
                          'You haven\'t visited any doctors before',
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: doctorsData.doctorsUserHaveVisited.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          width: 150,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      doctorsData.doctorsUserHaveVisited[index]
                                          .imageUrl,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      doctorsData
                                          .doctorsUserHaveVisited[index].name,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  Text(
                                    doctorsData
                                        .doctorsUserHaveVisited[index].type,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
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
