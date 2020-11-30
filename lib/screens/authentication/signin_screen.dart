import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './signup_screen.dart';
import 'package:doctor_appointment/widgets/authentication/signin_form.dart';
import '../../helpers/db_helper.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      DBHelper.setData(
        colRef1: 'users',
        id1: userCredential.user.uid,
        data: {
          'firstName': userCredential.additionalUserInfo.profile['given_name'],
          'lastName': userCredential.additionalUserInfo.profile['family_name'],
          'gender': '',
          'email': userCredential.user.email
        },
      );
    } on PlatformException catch (_) {
      var message = 'An error occured, please try again later!';
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(message),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 100,
                    right: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Sign in',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SigninForm(),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot your password?',
                              ),
                              textColor: Theme.of(context).accentColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text('Social Login'),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                      'assets/images/facebook.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                        'assets/images/google-symbol.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: _signInWithGoogle,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'You dont have an account ?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SignupScreen.routeName);
                              },
                              child: const Text(
                                'Register now',
                              ),
                              textColor: Theme.of(context).accentColor)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
