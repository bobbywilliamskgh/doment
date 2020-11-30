import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth;
  var _userEmail = '';
  var _userPassword = '';
  var _isLoading = false;
  void _tryLogin() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      // send _userEmail and _userPassword to firebase for authentication
      try {
        setState(() {
          _isLoading = true;
        });
        await _auth.signInWithEmailAndPassword(
          email: _userEmail.trim(),
          password: _userPassword.trim(),
        );
      } on PlatformException catch (err) {
        var message = 'An error occured, please check your credentials!';
        if (err.message != null) {
          message = err.message;
        }
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        print(error);
        var message = error.toString();
        message = message.substring(
            message.indexOf(']') + 1,
            message
                .length); // to get error message after '[firebase_auth/.....]'
        print(error);
        Scaffold.of(context).hideCurrentSnackBar();
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().then((_) {
      _auth = FirebaseAuth.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            onSaved: (newValue) {
              _userEmail = newValue;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty || value.length < 7) {
                return 'Password must be at least 7 characters long.';
              }
              return null;
            },
            onSaved: (newValue) {
              _userPassword = newValue;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          if (_isLoading) CircularProgressIndicator(),
          if (!_isLoading)
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width -
                  40, // Device width - (padding right + padding left)
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onPressed: _tryLogin,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                color: Theme.of(context).accentColor,
              ),
            ),
        ],
      ),
    );
  }
}
