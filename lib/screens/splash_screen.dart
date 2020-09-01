import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qchatapp/screens/main_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

bool loggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogIn();
    Future.delayed(Duration(seconds: 3),
            (){
         if (loggedIn == true) {
           Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => MainScreen()
            ));
         }
         else{
           Navigator.pushReplacement(context, MaterialPageRoute(
               builder: (context) => LoginScreen()
           ));
         }
        }
    );
  }

  checkLogIn() async {
    await FirebaseAuth.instance.currentUser().then((value){
      if(value != null  ) {
        setState(() {
          loggedIn = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [

            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff38ef7d), Color(0xff2cb9b0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
            ),

            Center(
              child: Container(
                child: Text(
                    "Q CHAT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 65,
                      fontFamily: 'sf_pro_medium'
                    ),
                ),
              ),
            )


          ],
        ),
      )
    );
  }
}
