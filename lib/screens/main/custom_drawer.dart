import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctor_appointment/providers/auth_user.dart';
import './doctor_list_screen.dart';
import './my_appointments_screen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFirstName =
        Provider.of<AuthUser>(context, listen: false).firstName;
    final userLastName = Provider.of<AuthUser>(context, listen: false).lastName;
    return Drawer(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        color: Theme.of(context).accentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                '$userFirstName $userLastName',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyText1.fontWeight,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'My doctors',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyText2.fontWeight,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(DoctorListScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'My appointments',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyText2.fontWeight,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(MyAppointmentsScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.local_hospital,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                'Hospitals',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
                  fontWeight: Theme.of(context).textTheme.bodyText2.fontWeight,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
