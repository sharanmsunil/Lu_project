import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_loom/average_cycle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lu_Welcome(),
    );
  }
}


class Lu_Welcome extends StatefulWidget {
  @override
  State<Lu_Welcome> createState() => _Lu_SplashState();
}

class _Lu_SplashState extends State<Lu_Welcome> {
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
              margin: EdgeInsets.only(top: 60),
              child: Text('Welcome!',
                  style: GoogleFonts.kameron(fontSize: 30, color: Colors.white)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text('Please answer a few questions and we will',
                  style: GoogleFonts.kameron(fontSize: 12, color: Colors.white)),
            ),
            Text('Personalize the app for you',
                style: GoogleFonts.kameron(fontSize: 12, color: Colors.white)),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Avg_Cycle()));
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.kameron(
                        fontSize: 20, color: Color(0xff812ac7)),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text.rich(TextSpan(
                      text: "By tapping \"Continue\" you agree to our ",
                      style: GoogleFonts.kameron(
                          fontSize: 10, color: Colors.grey[300]),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'terms of Service',
                        style: GoogleFonts.kameron(
                            fontSize: 10,
                            color: Colors.grey[300],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey[300]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // code to open / launch terms of service link here
                          }),
                    TextSpan(text: '\n                               '),
                    TextSpan(
                        text: ' and ',
                        style: GoogleFonts.kameron(
                          fontSize: 10,
                          color: Colors.grey[300],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'privacy policy',
                              style: GoogleFonts.kameron(
                                  fontSize: 10,
                                  color: Colors.grey[300],
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.grey[300]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // code to open / launch privacy policy link here
                                })
                        ])
                  ]))),
            )
          ],
        ),
      ),
    );
  }
}
