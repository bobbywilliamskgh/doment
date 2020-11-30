import 'package:doctor_appointment/providers/auth_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home_screen.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';
import 'settings_screen.dart';
import '../new_appointment/health_concern_screen.dart';
import 'package:doctor_appointment/screens/main/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentTabIndex = 0;
  var _pageIndex = 0;
  var _pages = [
    HomeScreen(),
    ProfileScreen(),
    MessagesScreen(),
    SettingsScreen(),
  ];

  void _selectTabIndex(int selectedIndex) {
    setState(() {
      _currentTabIndex = selectedIndex;
      _pageIndex = _currentTabIndex;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthUser>(context, listen: false).fetchAndSetUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ],
        centerTitle: true,
        title: Text(
          'Doctor Appointment',
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 16,
          ),
        ),
      ),
      body: _pages[_pageIndex],
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HealthConcernScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _selectTabIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
