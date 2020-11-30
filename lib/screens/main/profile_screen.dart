import 'package:doctor_appointment/providers/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import '../../widgets/profile/profile_tab.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isInternetConnected = true;

  Future<void> _initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetConnected = false;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occured. Please check your internet connection !',
          ),
          backgroundColor: Theme.of(context).errorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return !_isInternetConnected
        ? Container()
        : Column(
            children: [
              FutureBuilder(
                future: Provider.of<AuthUser>(context, listen: false)
                    .fetchAndSetUserData(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (dataSnapshot.hasError) {
                    // show error dialog
                  }
                  return Consumer<AuthUser>(
                    builder: (_, authUser, ch) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueGrey[100],
                          ),
                          title: Text(
                              '${authUser.firstName} ${authUser.lastName}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(authUser.email),
                              ),
                              const Text('Add your number'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ProfileTab(),
              ),
            ],
          );
  }
}
