import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor_appointment/providers/test_results.dart' as tr;
import 'package:intl/intl.dart';

class TestResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Test results',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('See All'),
              textColor: Theme.of(context).accentColor,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        FutureBuilder(
          future: Provider.of<tr.TestResults>(context, listen: false)
              .fetchAndSetTestResults(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              // show info to user
            }
            return Consumer<tr.TestResults>(
              builder: (_, testResultsData, ch) {
                if (testResultsData.testResults.length == 0) {
                  return Container(
                    color: Colors.blueGrey[100],
                    height: 100,
                    child: Center(
                      child: const Text('No Test Results'),
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
                            'assets/images/checkup.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        title: Text(
                          testResultsData.testResults[0].title,
                        ),
                        subtitle: Text(
                          DateFormat('d MMMM yyyy')
                              .format(testResultsData.testResults[0].date),
                        ),
                      ),
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
