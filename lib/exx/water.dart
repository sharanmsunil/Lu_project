import 'package:flutter/material.dart';
import 'package:luna_loom/exx/waterani.dart';

void main() {
  runApp(WaterReminderApp());
}

class WaterReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Reminder App',
      home: AnimationFlow(),
    );
  }
}

class WaterReminderScreen extends StatefulWidget {
  @override
  _WaterReminderScreenState createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  int _waterIntakeGoal = 8; // Set your daily water intake goal in cups
  int _currentWaterIntake = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Reminder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Daily Water Intake Goal: $_waterIntakeGoal cups',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Current Water Intake: $_currentWaterIntake cups',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentWaterIntake += 1;
                  if (_currentWaterIntake >= _waterIntakeGoal) {
                    _showCongratulationsDialog();
                  }
                });
              },
              child: Text('Drink Water'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have reached your daily water intake goal.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
