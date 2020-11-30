import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:doctor_appointment/providers/test_results.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TestResults>(context, listen: false)
          .fetchAndSetTestResults(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // Show info to user
        }
        return Consumer<TestResults>(
          builder: (_, test, ch) {
            if (test.testResults.isEmpty) {
              return Center(
                child: const Text('No Test Results...'),
              );
            } else {
              return ListView.builder(
                itemCount: test.testResults.length,
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
                            'assets/images/checkup.png',
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
                              test.testResults[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              DateFormat('d/MM/yyyy').format(
                                test.testResults[index].date,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            InkWell(
                              child: Text(
                                'See reports',
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
