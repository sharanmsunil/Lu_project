import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'average_period.dart';

class Avg_Cycle extends StatefulWidget {
  const Avg_Cycle({super.key});

  @override
  State<Avg_Cycle> createState() => _Avg_CycleState();
}

class _Avg_CycleState extends State<Avg_Cycle> {
  var avgcyc = 28;

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
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text('How many days does your cycle',
                  style: GoogleFonts.kameron(fontSize: 20, color: Colors.white)),
            ),
            Text('last on average?',
                style: GoogleFonts.kameron(fontSize: 20, color: Colors.white)),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Stack(
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
                    boxShadow: [BoxShadow(color: Color(0xff812ac7),blurRadius: 5,spreadRadius: .5)]),
                  ),
                  Positioned(
                      child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                    boxShadow: [BoxShadow(color: Color(0xff812ac7),blurRadius: 10,spreadRadius: .5)]),
                  )),
                  Container(
                    child: NumberPicker(
                        minValue: 20,
                        maxValue: 50,
                        value: avgcyc,
                        itemHeight: 45,
                        itemWidth: 45,
                        itemCount: 7,
                        axis: Axis.horizontal,
                        selectedTextStyle: TextStyle(
                          color: Color(0xff812ac7),
                          fontSize: 25,
                        ),
                        textStyle: TextStyle(color: Color(0xffbc84e9),fontSize: 15),
                        onChanged: (value) => setState(
                              () => avgcyc = value,
                            )),
                  ),
                ],
              ),
            ),
            Container(margin: EdgeInsets.only(top: 5),child: Text('days',style: GoogleFonts.kameron(fontSize: 15, color: Colors.white))),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Avg_Period(avgcyc: avgcyc,)));
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.kameron(
                        fontSize: 20, color: Color(0xff812ac7)),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Avg_Period(avgcyc: avgcyc,)));
                  },
                  child: Text(
                    "I don't remember",
                    style: GoogleFonts.kameron(
                        fontSize: 15, color: Color(0xffbc84e9)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
