import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qchatapp/Authentication/auth.dart';
import 'package:qchatapp/screens/login_screen.dart';
import 'package:qchatapp/screens/profile.dart';
import 'package:qchatapp/screens/settings.dart';

import 'home.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String userName,userId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileInfo();
  }


  getProfileInfo() async {
    await AuthService.getUserNameSharePref().then((value) {
      setState(() {
        userName = value;
      });
    });

    await AuthService.getUserIdSharedPref().then((value) {
      setState(() {
        userId = value;
      });
    });
  }


  final List<Widget> _widgetOptions = <Widget>[
    Profile(),
    Home(),
    Settings(),

  ];

  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onBackPressed() async{

    if(_selectedIndex != 1)  {

      setState(() {
        _selectedIndex = 1;
      });
      return false;
    }
    else{

      return true;
    }

  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
         body: _widgetOptions.elementAt(_selectedIndex),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          selectedLabelStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.w700),
          unselectedItemColor:Colors.black,
          unselectedLabelStyle: TextStyle(color: Colors.green,fontWeight: FontWeight.w700),
          showUnselectedLabels: true,
          currentIndex:  _selectedIndex,
          onTap: _onItemTapped,

          items: [

            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              title:Text("Profile"),
            ),

            BottomNavigationBarItem(
              icon:Icon(Icons.message,),
              title:Text("Home"),
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title:Text("Setting"),
            ),

          ],
        ),
      ),
    );
  }
}
