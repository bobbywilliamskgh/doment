import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff042c93),
        child: Center(
          child: AlertDialog(
            content: const Text(
                'Cannot access data. Please check your internet connection.'),
            actions: [
              FlatButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: const Text('close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
