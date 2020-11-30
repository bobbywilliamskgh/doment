import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Settings(),
          General(),
          Accounts(),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
          height: 40,
          child: Text('Settings'),
        ),
        SwitchListTile(
          value: false,
          onChanged: (newValue) {},
          title: Text('Health tips for you'),
          subtitle: Text(
            'Get information tips for your health lifestyle',
          ),
        ),
        ListTile(
          leading: Text(
            'Notification settings',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {},
        )
      ],
    );
  }
}

class General extends StatelessWidget {
  Widget buildGeneralSetting(String title, BuildContext ctx) {
    return ListTile(
      leading: Text(
        title,
        style: Theme.of(ctx).textTheme.bodyText1,
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.grey[200],
          height: 40,
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Text('General'),
        ),
        buildGeneralSetting('Language', context),
        buildGeneralSetting('About Doment App', context),
        buildGeneralSetting('Privacy Policy', context),
        buildGeneralSetting('Help and support', context),
        buildGeneralSetting('Rate Doment App', context),
      ],
    );
  }
}

class Accounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.grey[200],
          height: 50,
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: const Text('Accounts'),
        ),
        ListTile(
          leading: Text(
            'Logout',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            Icons.exit_to_app,
            color: Theme.of(context).accentColor,
          ),
          onTap: () async {
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
          },
        )
      ],
    );
  }
}
