import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

enum Gender {
  Male,
  Female,
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  FirebaseAuth _auth;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Gender _selectedGender;
  var _firstName = '';
  var _lastName = '';
  var _email = '';
  var _password = '';
  var _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().then((_) {
      _auth = FirebaseAuth.instance;
    });
  }

  void _chooseGender(Gender genderChosen) {
    _selectedGender = genderChosen;
  }

  // To save String type in database
  String get genderString {
    if (_selectedGender == Gender.Male) {
      return 'Male';
    } else {
      return 'Female';
    }
  }

  void _trySignup() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isValid || _selectedGender == null) {
      return;
    }
    _formKey.currentState.save();
    // authenticate to firebase
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      authResult = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'firstName': _firstName,
        'lastName': _lastName,
        'gender': genderString,
        'email': _email,
      });
      Navigator.of(context).pop();
    } on PlatformException catch (err) {
      print('test');
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
      var message = error.toString();
      print(message.indexOf('[') + 1);
      print(message.indexOf(']'));
      message = message.substring(message.indexOf(']') + 1,
          message.length); // to get error message after '[firebase_auth/.....]'
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

  TextFormField _buildTextFormField(String labelText) {
    return TextFormField(
      keyboardType: labelText == 'Email'
          ? TextInputType.emailAddress
          : (labelText == 'First Name' || labelText == 'Last Name')
              ? TextInputType.name
              : TextInputType.text,
      controller: labelText == 'Password' ? _passwordController : null,
      validator: (value) {
        if (labelText == 'First Name' || labelText == 'Last Name') {
          if (value.isEmpty || value.length < 3) {
            return 'Please enter at least 3 characters.';
          }
        } else if (labelText == 'Email') {
          if (value.isEmpty || !value.contains('@')) {
            return 'Please enter a valid email address.';
          }
        } else if (labelText == 'Password') {
          if (value.isEmpty || value.length < 7) {
            return 'Password must be at least 7 characters.';
          }
        } else if (labelText == 'Confirm Password') {
          if (value.isEmpty || value != _passwordController.text) {
            return 'Passwords do not match!';
          }
        }
        return null;
      },
      onSaved: (newValue) {
        switch (labelText) {
          case 'First Name':
            _firstName = newValue;
            break;
          case 'Last Name':
            _lastName = newValue;
            break;
          case 'Email':
            _email = newValue;
            break;
          case 'Password':
            _password = newValue;
            break;
          case 'Confirm Password':
            _password = newValue;
            break;
          default:
            break;
        }
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
      ),
      obscureText: (labelText == 'Password' || labelText == 'Confirm Password')
          ? true
          : false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextFormField('First Name'),
          _buildTextFormField('Last Name'),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Gender:',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          GenderButton(_chooseGender),
          _buildTextFormField('Email'),
          _buildTextFormField('Password'),
          _buildTextFormField('Confirm Password'),
          const SizedBox(
            height: 40,
          ),
          if (_isLoading) CircularProgressIndicator(),
          if (!_isLoading)
            Container(
              width: MediaQuery.of(context).size.width -
                  40, // Device width - (padding left + padding right)
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onPressed: _trySignup,
                child: Text(
                  'Sign up',
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

class GenderButton extends StatefulWidget {
  final Function onSelectedGender;
  GenderButton(this.onSelectedGender);
  @override
  _GenderButtonState createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  Gender _selectedGender;

  void _selectGender(Gender gender) {
    widget.onSelectedGender(gender);
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RadioListTile(
              value: Gender.Male,
              groupValue: _selectedGender,
              onChanged: _selectGender,
              title: const Text(
                'Male',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: RadioListTile(
              value: Gender.Female,
              groupValue: _selectedGender,
              onChanged: _selectGender,
              title: const Text(
                'Female',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
