import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:luna_loom/home_screen.dart';

class Prvs_Mns extends StatefulWidget {
  int avgcyc;
  int avgprd;
   Prvs_Mns({super.key,required this.avgcyc,required this.avgprd});

  @override
  State<Prvs_Mns> createState() => _Prvs_MnsState(avgcyc: avgcyc, avgprd: avgprd);
}

class _Prvs_MnsState extends State<Prvs_Mns> {
  late DateTime selectedDate;
  int avgcyc;
  int avgprd;
  _Prvs_MnsState({required this.avgcyc,required this.avgprd});
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
              child: Text('When did your previous',
                  style:
                      GoogleFonts.kameron(fontSize: 20, color: Colors.white)),
            ),
            Text('menses begin?',
                style: GoogleFonts.kameron(fontSize: 20, color: Colors.white)),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: DatePickerWidget(
                looping: false,
                firstDate: DateTime(2020,01,01),
                lastDate: DateTime.now(),
                initialDate: DateTime(2024,01,01),
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('en'),
                onChange: (DateTime newDate,_) => selectedDate = newDate,
                pickerTheme: DateTimePickerTheme(
                  backgroundColor: Color(0xffbc84e9),
                    itemTextStyle: TextStyle(color: Colors.white,fontSize: 19),
                    dividerColor: Color(0xff812ac7),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home_Screen(avgcyc: avgcyc, avgprd: avgprd,
                          //selectedDate: selectedDate,
                        )));
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.kameron(
                        fontSize: 20, color: Color(0xff812ac7)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
