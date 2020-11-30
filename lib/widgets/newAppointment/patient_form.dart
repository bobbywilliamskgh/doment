import 'package:doctor_appointment/providers/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientForm extends StatefulWidget {
  final FormController controller;
  final Function onSavedForm;

  PatientForm(this.controller, this.onSavedForm);
  @override
  _PatientFormState createState() => _PatientFormState(controller);
}

class _PatientFormState extends State<PatientForm> {
  _PatientFormState(FormController _controller) {
    _controller.save = _save;
  }
  var _selectedRadio = 0;
  var _userFullName = '';
  var _patientFullName = '';
  var _userPhoneNumber = '';
  var _patientPhoneNumber = '';
  var _userEmail = '';
  var _patientEmail = '';
  final _userNameController = TextEditingController();
  final _userPhoneNumberController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _patientNameController = TextEditingController();
  final _patientPhoneNumberController = TextEditingController();
  final _patientEmailController = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String get formInformation {
    if (_selectedRadio == 0) {
      return 'information about [userAuth]';
    } else {
      return 'patient details';
    }
  }

  void _selectRadio(int newValue) {
    setState(() {
      _selectedRadio = newValue;
    });
  }

  void _save() {
    print('save success...');
    var isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    print('valid...');
    _formKey.currentState.save();
    if (_selectedRadio == 0) {
      widget.onSavedForm({
        'name': _userFullName,
        'phoneNumber': _userPhoneNumber,
        'email': _userEmail,
      });
    } else {
      widget.onSavedForm({
        'name': _patientFullName,
        'phoneNumber': _patientPhoneNumber,
        'email': _patientEmail,
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _userPhoneNumberController.dispose();
    _userEmailController.dispose();
    _patientNameController.dispose();
    _patientPhoneNumberController.dispose();
    _patientEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<AuthUser>(context, listen: false);
    return Column(
      children: [
        Container(
          height: 10,
          width: double.infinity,
          color: Colors.grey[350],
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('This appointment for:'),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        value: 0,
                        groupValue: _selectedRadio,
                        onChanged: _selectRadio,
                        title:
                            Text('${authUser.firstName} ${authUser.lastName}'),
                      ),
                      Divider(),
                      RadioListTile(
                        value: 1,
                        groupValue: _selectedRadio,
                        onChanged: _selectRadio,
                        title: Text('Someone else'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text('Please provide following $formInformation:'),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedRadio == 0)
                      const Text(
                        'Full Name*',
                        style: TextStyle(color: Colors.grey),
                      ),
                    if (_selectedRadio == 1)
                      const Text(
                        'Patient\'s Full Name*',
                        style: TextStyle(color: Colors.grey),
                      ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_phoneNumberFocusNode);
                      },
                      keyboardType: TextInputType.text,
                      controller: _selectedRadio == 0
                          ? _userNameController
                          : _patientNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (_selectedRadio == 0 &&
                                value.length <
                                    authUser.firstName.length +
                                        authUser.lastName.length ||
                            _selectedRadio == 1 && value.length < 7) {
                          return 'Characters is too sort.';
                        }
                        if (value.isEmpty) {
                          return 'This field is required.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (_selectedRadio == 0) {
                          _userFullName = newValue;
                        } else {
                          _patientFullName = newValue;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Your Mobile*',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextFormField(
                      focusNode: _phoneNumberFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                      keyboardType: TextInputType.phone,
                      controller: _userPhoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Enter your number',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required.';
                        }
                        if (value.length < 10) {
                          return 'Please enter a number at least 10 digit';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userPhoneNumber = newValue;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_selectedRadio == 1)
                      const Text(
                        'Patient\'s Mobile*',
                        style: TextStyle(color: Colors.grey),
                      ),
                    if (_selectedRadio == 1)
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _patientPhoneNumberController,
                        decoration: InputDecoration(
                          hintText: 'Enter Patient\'s Mobile Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field is required.';
                          }
                          if (value.length < 10) {
                            return 'Please enter a number at least 10 digit';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _patientPhoneNumber = newValue;
                        },
                      ),
                    if (_selectedRadio == 1)
                      const SizedBox(
                        height: 16,
                      ),
                    if (_selectedRadio == 1)
                      const Text(
                        'Patient\'s Email*',
                        style: TextStyle(color: Colors.grey),
                      ),
                    if (_selectedRadio == 0)
                      const Text(
                        'Your Email*',
                        style: TextStyle(color: Colors.grey),
                      ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _save(),
                      controller: _selectedRadio == 0
                          ? _userEmailController
                          : _patientEmailController,
                      decoration: InputDecoration(
                        hintText: _selectedRadio == 0
                            ? 'Enter your email'
                            : 'Enter Patient\'s Email ID',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'This field is required';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (_selectedRadio == 0) {
                          _userEmail = newValue;
                        } else {
                          _patientEmail = newValue;
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// To call save method from parent class
class FormController {
  void Function() save;
}
