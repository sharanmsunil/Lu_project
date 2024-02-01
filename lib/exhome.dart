import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ex_home extends StatefulWidget {
  const Ex_home({super.key});

  @override
  State<Ex_home> createState() => _Ex_homeState();
}

class _Ex_homeState extends State<Ex_home> {
  late SharedPreferences preferences;
  late int avgcyc;

  @override
  void initState() {
    fetchData();
    super.initState();
  }
  void fetchData()async{
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgcyc =preferences.getInt("AvgCycle")!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
            Text('$avgcyc')
          ],
        ),
      ),
    );
  }
}
