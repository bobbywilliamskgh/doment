import 'package:doctor_appointment/providers/examinations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Examination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Examinations>(context, listen: false)
          .fetchAndSetExaminations(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // Show info to user
        }
        return Consumer<Examinations>(
          builder: (_, examinations, ch) {
            if (examinations.examinations.isEmpty) {
              return Center(
                child: const Text('No Examination...'),
              );
            } else {
              return ListView.builder(
                itemCount: examinations.examinations.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(4),
                        color: Colors.blueGrey[100]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 40,
                          child: Image.asset(
                            'assets/images/examination.png',
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
                              '${examinations.examinations[index].title} Examination',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DateFormat('d/MM/yyyy').format(
                                  examinations.examinations[index].date),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            InkWell(
                              child: Text(
                                'See results',
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
