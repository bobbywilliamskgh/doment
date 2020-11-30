import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor_appointment/providers/prescriptions.dart'
    as presciptions;

class Prescriptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Your Prescriptions',
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
          future:
              Provider.of<presciptions.Prescriptions>(context, listen: false)
                  .fetchAndSetPrescriptions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              // show info to user
            }
            return Consumer<presciptions.Prescriptions>(
              builder: (_, prescriptionsData, ch) {
                if (prescriptionsData.prescriptions.length == 0) {
                  return Container(
                    color: Colors.blueGrey[100],
                    height: 100,
                    child: Center(
                      child: const Text('No Prescriptions'),
                    ),
                  );
                } else {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.blueGrey[100],
                    height: 100,
                    child: Center(
                      child: ListTile(
                        leading: Container(
                          height: 80,
                          width: 50,
                          child: Image.asset(
                            'assets/images/medical-prescription.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        title: Text(
                          '${prescriptionsData.prescriptions[0].prescriptionName} Recipe',
                        ),
                        subtitle: Text(
                          'Given by ${prescriptionsData.prescriptions[0].givenBy}',
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
