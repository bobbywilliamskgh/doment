import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor_appointment/providers/doctors.dart';
import 'package:doctor_appointment/widgets/newAppointment/choose_time_slot.dart';

class TimeSlotScreen extends StatelessWidget {
  static const routeName = '/time-slot';
  @override
  Widget build(BuildContext context) {
    final doctorId = ModalRoute.of(context).settings.arguments as String;
    final doctor =
        Provider.of<Doctors>(context, listen: false).findById(doctorId);
    return ChangeNotifierProvider.value(
      value: doctor,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).appBarTheme.iconTheme,
          elevation: 2,
          centerTitle: true,
          title: const Text(
            'Time slot',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(doctor.imageUrl),
                ),
                title: Text(
                  doctor.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(doctor.type),
              ),
              const SizedBox(height: 8),
              ChooseTimeSlot(doctor.availablity, doctor),
            ],
          ),
        ),
      ),
    );
  }
}
