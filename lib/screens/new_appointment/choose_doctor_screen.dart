import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor_appointment/providers/doctors.dart';
import 'package:doctor_appointment/widgets/newAppointment/choose_doctor_item.dart';

class ChooseDoctorScreen extends StatelessWidget {
  static const routeName = '/choose-doctor';
  @override
  Widget build(BuildContext context) {
    final hcId = ModalRoute.of(context).settings.arguments
        as String; // Health Concern Id
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Doctor',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder(
        future:
            Provider.of<Doctors>(context, listen: false).fetchAndSetDoctors(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapshot.hasError) {
            // Show SnackBar
          }
          return Consumer<Doctors>(
            builder: (_, doctors, child) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 60,
                          child: Text(
                            'Choose a Doctor',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                        doctors.filterByHcId(hcId).map((doctor) {
                      return Column(
                        children: [
                          ChooseDoctorItem(
                            id: doctor.id,
                            name: doctor.name,
                            type: doctor.type,
                            rate: doctor.rate,
                            feeStart: doctor.feeStart,
                            imageUrl: doctor.imageUrl,
                            location: doctor.location,
                          ),
                          Divider(),
                        ],
                      );
                    }).toList()),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
