import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import './screens/authentication/signin_screen.dart';
import './screens/authentication/signup_screen.dart';
import './providers/doctors.dart';
import './screens/main/main_screen.dart';
import './screens/new_appointment/choose_doctor_screen.dart';
import './screens/new_appointment/time_slot_screen.dart';
import './screens/new_appointment/patient_details_screen.dart';
import './providers/auth_user.dart';
import './providers/appointments.dart';
import './screens/new_appointment/successful_booking_screen.dart';
import './screens/new_appointment/appointment_details_screen.dart';
import './providers/prescriptions.dart';
import './providers/test_results.dart';
import './providers/examinations.dart';
import './screens/main/doctor_list_screen.dart';
import './screens/main/my_appointments_screen.dart';
import './screens/prescription_detail_screen.dart';
import './screens/error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isInternetConnected = true;

  void getConnect() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isInternetConnected = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getConnect();
  }

  @override
  Widget build(BuildContext context) {
    print('build...');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Doctors(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => Appointments(),
        ),
        ChangeNotifierProvider(
          create: (_) => Prescriptions(),
        ),
        ChangeNotifierProvider(
          create: (_) => TestResults(),
        ),
        ChangeNotifierProvider(
          create: (_) => Examinations(),
        ),
      ],
      child: MaterialApp(
        title: 'Doment',
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color.fromRGBO(5, 105, 211, 1),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.blue),
          ),
          fontFamily: 'Roboto',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                bodyText2: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
        home: _isInternetConnected
            ? StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return MainScreen();
                  }
                  return SigninScreen();
                },
              )
            : ErrorScreen(),
        routes: {
          SignupScreen.routeName: (ctx) => SignupScreen(),
          ChooseDoctorScreen.routeName: (ctx) => ChooseDoctorScreen(),
          TimeSlotScreen.routeName: (ctx) => TimeSlotScreen(),
          PatientDetailsScreen.routeName: (ctx) => PatientDetailsScreen(),
          SuccessfulBookingScreen.routeName: (ctx) => SuccessfulBookingScreen(),
          AppointmentDetailsScreen.routeName: (ctx) =>
              AppointmentDetailsScreen(),
          DoctorListScreen.routeName: (ctx) => DoctorListScreen(),
          MyAppointmentsScreen.routeName: (ctx) => MyAppointmentsScreen(),
          PrescriptionDetailScreen.routeName: (ctx) =>
              PrescriptionDetailScreen(),
        },
      ),
    );
  }
}
