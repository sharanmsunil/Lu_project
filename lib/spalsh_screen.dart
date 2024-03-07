import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      home: LuSplash(),
    );
  }
}

class LuSplash extends StatefulWidget {
  const LuSplash({super.key});

  @override
  State<LuSplash> createState() => _LuSplashState();
}

class _LuSplashState extends State<LuSplash> {
  late SharedPreferences preferences;
  late bool isANewUser=false;
  @override
  void initState() {
    checkTheUserIsAlreadyLoggedIn();
    super.initState();
  }
  void checkTheUserIsAlreadyLoggedIn() async {
    var preferences = await SharedPreferences.getInstance();
    isANewUser = preferences.getBool('newUser') ?? false ;
    if (isANewUser == false) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LuWelcome()));
      });
    } else if (isANewUser == true) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LuWelcome()));
      });
    }
    }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: LuColors.bgColor,
      body: Center(
        child: LogoWidget(),
      ),
    );
  }
}

