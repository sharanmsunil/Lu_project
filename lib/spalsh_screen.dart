import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:luna_loom/home_screen.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:luna_loom/welcome_screen.dart';
import 'package:luna_loom/widgets/logo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
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
     Future.delayed(const Duration(seconds: 3),(){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Lu_Welcome()));
     });
    }else if (isANewUser == true){
      Future.delayed(const Duration(seconds: 3),(){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home_Screen()));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuColors.bgColor,
      body: const Center(
        child: LogoWidget(),
      ),
    );
  }
}

