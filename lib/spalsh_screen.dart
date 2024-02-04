import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_loom/home_screen.dart';
import 'package:luna_loom/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lu_Splash(),
    );
  }
}

class Lu_Splash extends StatefulWidget {
  const Lu_Splash({super.key});

  @override
  State<Lu_Splash> createState() => _Lu_SplashState();
}

class _Lu_SplashState extends State<Lu_Splash> {
  late SharedPreferences preferences;
  late bool isANewUser=false;
  @override
  void initState() {
    checkTheUserIsAlreadyLoggedIn();
    super.initState();
  }
  void checkTheUserIsAlreadyLoggedIn() async {
    var preferences = await SharedPreferences.getInstance();
    isANewUser = preferences.getBool('newUser')! ;
    if (isANewUser == false) {
     Future.delayed(Duration(seconds: 3),(){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Lu_Welcome()));
     });
    }else if (isANewUser == true){
      Future.delayed(Duration(seconds: 3),(){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home_Screen()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbc84e9),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 50,
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/Lu/logo - Copy.png',
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: Text('Lu',
                  style: GoogleFonts.kolkerBrush(
                      fontSize: 130, color: Color(0xff812ac7))),
            ),
            Positioned(
                top: 190,
                child: Text(
                  'LunaLoom',
                  style: GoogleFonts.kameron(
                      fontSize: 45, color: Colors.white),
                )),
            Positioned(
                top: 240,
                child: Text(
                  'Illuminate Your Monthly Rhythm',
                  style: GoogleFonts.kameron(
                      fontSize: 10, color: Colors.white),
                )),
          ]),
        ),
      ),
    );
  }
}

