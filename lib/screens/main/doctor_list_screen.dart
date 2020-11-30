import 'package:flutter/material.dart';
import '../../widgets/drawer/doctor_list_item.dart';

class DoctorListScreen extends StatelessWidget {
  static const routeName = 'my-doctor-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'My doctor list',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
      body: DoctorListItem(),
    );
  }
}
