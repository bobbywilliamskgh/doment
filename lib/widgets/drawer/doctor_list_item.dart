import 'package:doctor_appointment/providers/doctors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Doctors>(context, listen: false)
          .fetchAndSetDoctorsThatUserHaveVisited(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          // show error info to user
        }
        return Consumer<Doctors>(builder: (_, doctors, ch) {
          if (doctors.doctorsUserHaveVisited.isEmpty) {
            return Center(
              child: const Text('You haven\'t visited any doctors before'),
            );
          } else {
            return ListView.builder(
              itemCount: doctors.doctorsUserHaveVisited.length,
              itemBuilder: (ctx, index) {
                return Container(
                  height: 150,
                  color: Colors.blueGrey[100],
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    leading: Container(
                      height: 130,
                      width: 60,
                      child: Image.network(
                        doctors.doctorsUserHaveVisited[index].imageUrl,
                      ),
                    ),
                    title: Text(
                      doctors.doctorsUserHaveVisited[index].name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    subtitle: Text(
                      doctors.doctorsUserHaveVisited[index].type,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {},
                      textColor: Theme.of(context).primaryColor,
                      child: const Text(
                        'Details',
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
      },
    );
  }
}
