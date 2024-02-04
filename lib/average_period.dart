import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_loom/previous_menses.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class Avg_Period extends StatefulWidget {

  Avg_Period({super.key});

  @override
  State<Avg_Period> createState() => _Avg_PeriodState();
}

class _Avg_PeriodState extends State<Avg_Period> {
  var avgprd = 5;
  late SharedPreferences preferences;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbc84e9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
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
            SizedBox(
              height: 30,
            ),
            Text('How long does your period last',
                style: GoogleFonts.kameron(fontSize: 20, color: Colors.white)),
            Text('on average?',
                style: GoogleFonts.kameron(fontSize: 20, color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff812ac7),
                            blurRadius: 5,
                            spreadRadius: .5)
                      ]),
                ),
                Positioned(
                    child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff812ac7),
                            blurRadius: 10,
                            spreadRadius: .5)
                      ]),
                )),
                Container(
                  child: NumberPicker(
                      haptics: true,
                      minValue: 1,
                      maxValue: 20,
                      value: avgprd,
                      itemHeight: 45,
                      itemWidth: 45,
                      itemCount: 7,
                      axis: Axis.horizontal,
                      selectedTextStyle: TextStyle(
                        color: Color(0xff812ac7),
                        fontSize: 25,
                      ),
                      textStyle:
                          TextStyle(color: Color(0xffbc84e9), fontSize: 15),
                      onChanged: (value) {setState(
                            () {
                              avgprd = value;
                              Vibration.vibrate(duration: 10,);
                            }
                          );}),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Text('days',
                    style: GoogleFonts.kameron(
                        fontSize: 15, color: Colors.white)),
            SizedBox(height: 30,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () async{
                    preferences = await SharedPreferences.getInstance();
                    int averageperiod = avgprd;
                    preferences.setInt("AvgPeriod", averageperiod);
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,a1,a2){
                      return Prvs_Mns();
                    },
                        transitionsBuilder: (context,an1,an2,child){
                          return FadeTransition(opacity: an1,child: child,);
                        },
                        transitionDuration: Duration(milliseconds: 200)));
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.kameron(
                        fontSize: 20, color: Color(0xff812ac7)),
                  )),
            SizedBox(height: 10,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () async{
                    preferences = await SharedPreferences.getInstance();
                    int averageperiod = avgprd;
                    preferences.setInt("AvgPeriod", averageperiod);
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,a1,a2){
                      return Prvs_Mns();
                    },
                        transitionsBuilder: (context,an1,an2,child){
                          return FadeTransition(opacity: an1,child: child,);
                        },
                        transitionDuration: Duration(milliseconds: 200)));
                  },
                  child: Text(
                    "I don't remember",
                    style: GoogleFonts.kameron(
                        fontSize: 15, color: Color(0xffbc84e9)),
                  )),
          ],
        ),
      ),
    );
  }
}
