import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:luna_loom/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class Prvs_Mns extends StatefulWidget {

   Prvs_Mns({super.key});

  @override
  State<Prvs_Mns> createState() => _Prvs_MnsState();
}

class _Prvs_MnsState extends State<Prvs_Mns> {
  late DateTime selectedDate;
  late SharedPreferences preferences;
  var prvmensis;
  var formate1;
  late bool isANewUser;

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
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: DatePickerWidget(
                looping: false,
                firstDate: DateTime(2023, 10),
                lastDate: DateTime.now(),
                initialDate: DateTime(2024,01,01),
                dateFormat: "dd-MMMM-yyyy",
                locale: DatePicker.localeFromString('en'),
                onChange: (DateTime newDate,_) {
                  setState(() {
                    selectedDate = newDate;
                    prvmensis = newDate;
                    formate1 = "${prvmensis.day}-${prvmensis.month}-${prvmensis.year}";
                    Vibration.vibrate(duration: 10,);
                  });
                } ,
                pickerTheme: DateTimePickerTheme(
                  backgroundColor: Color(0xffbc84e9),
                    itemTextStyle: TextStyle(color: Colors.white,fontSize: 19),
                    dividerColor: Color(0xff812ac7),
                ),
              ),
            ),
        SizedBox(height: 30,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3, minimumSize: Size(220, 50)),
                  onPressed: () async{
                    preferences = await SharedPreferences.getInstance();
                    preferences.setBool('newUser', true);
                    if(prvmensis==null){
                      String backupdate ='2024-01-01 00:00:00.000';
                      prvmensis=DateTime.parse(backupdate);
                      preferences.setString("LastMensis", prvmensis.toString());
                    }else {
                      preferences.setString("LastMensis", prvmensis.toString());
                    }
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home_Screen()),(route)=>false);
                  },
                  child: Text(
                    'Continue',
                    style: GoogleFonts.kameron(
                        fontSize: 20, color: Color(0xff812ac7)),
                  )),
          ],
        ),
      ),
    );
  }
}
