import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:doctor_appointment/providers/prescriptions.dart';
import '../../screens/prescription_detail_screen.dart';
import '../../models/prescription.dart' as prescModel;

class Prescription extends StatelessWidget {
  String dateGiven(DateTime dt) {
    return DateFormat('d/MM/yyyy').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Prescriptions>(context, listen: false)
          .fetchAndSetPrescriptions(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // Show info to user
        }
        return Consumer<Prescriptions>(
          builder: (_, presc, ch) {
            if (presc.prescriptions.isEmpty) {
              return Center(
                child: const Text('No Prescriptions...'),
              );
            } else {
              return ListView.builder(
                itemCount: presc.prescriptions.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(4),
                      color: Colors.blueGrey[100],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 40,
                          child: Image.asset(
                            'assets/images/prescription.png',
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
                              '${presc.prescriptions[index].prescriptionName} Recipe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Given at ${dateGiven(presc.prescriptions[index].dateGiven)}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            InkWell(
                              child: Text(
                                'See prescription',
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PrescriptionDetailScreen.routeName,
                                  arguments: prescModel.Prescription(
                                    id: presc.prescriptions[index].id,
                                    dateGiven:
                                        presc.prescriptions[index].dateGiven,
                                    givenBy: presc.prescriptions[index].givenBy,
                                    prescriptionName: presc
                                        .prescriptions[index].prescriptionName,
                                    recipes: presc.prescriptions[index].recipes,
                                  ),
                                );
                              },
                            )
                          ],
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
    );
  }
}
