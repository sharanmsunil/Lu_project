import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_loom/average_cycle.dart';
import 'package:numberpicker/numberpicker.dart';

class Lu_Settings extends StatefulWidget {
  var avgcyc;
  var avgprd;

  Lu_Settings({super.key, required this.avgcyc, required this.avgprd});

  @override
  State<Lu_Settings> createState() =>
      _Lu_SettingsState(avgcyc: avgcyc, avgprd: avgprd);
}

class _Lu_SettingsState extends State<Lu_Settings> {
  var avgcyc;
  var avgprd;
  var cday =28;
  var pday =5;

  _Lu_SettingsState({required this.avgcyc, required this.avgprd});
  bool isCTickVisible = false;
  bool isPTickVisible = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    'Settings',
                    style:
                        GoogleFonts.kameron(color: Colors.black, fontSize: 20),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    'Duration of cycle',
                    style: GoogleFonts.kameron(
                        color: Colors.grey[600], fontSize: 15),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 1, minimumSize: Size(300, 40)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Container(
                                  height: 200,
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Column(
                                      children: <Widget>[
                                        Text(
                                          'Duration of cycle',
                                          style:
                                          GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
                                        ),
                                        Text(
                                          'Choose the number of days',
                                          style:
                                          GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 15),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              alignment: Alignment.center,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                            NumberPicker(
                                                minValue: 20,
                                                maxValue: 50,
                                                value: cday,
                                                //widget.avgcyc,
                                                itemHeight: 30,
                                                itemWidth: 30,
                                                itemCount: 5,
                                                axis: Axis.vertical,
                                                selectedTextStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                ),
                                                textStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 15),
                                                onChanged: (value) => setState(
                                                      () => cday
                                                          //widget.avgcyc
                                                          = value,
                                                    )),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                )),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                    child: Text(
                                  'Select',
                                  style: GoogleFonts.kameron(
                                      fontSize: 15, color: Color(0xff812ac7)),
                                )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "$cday days",
                      style: GoogleFonts.kameron(
                          fontSize: 15, color: Color(0xffbc84e9)),
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Duration of period',
                    style: GoogleFonts.kameron(
                        color: Colors.grey[600], fontSize: 15),
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 1, minimumSize: Size(300, 40)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Container(
                                  height: 200,
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Column(
                                      children: <Widget>[
                                        Text(
                                          'Duration of period',
                                          style:
                                          GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
                                        ),
                                        Text(
                                          'Choose the number of days',
                                          style:
                                          GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 15),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              alignment: Alignment.center,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade200),
                                              ),
                                            ),
                                            NumberPicker(
                                                minValue: 1,
                                                maxValue: 20,
                                                value: pday,
                                                //widget.avgprd,
                                                itemHeight: 30,
                                                itemWidth: 30,
                                                itemCount: 5,
                                                axis: Axis.vertical,
                                                selectedTextStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                ),
                                                textStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 15),
                                                onChanged: (value) => setState(
                                                      () =>
                                                      pday
                                                          //widget.avgprd
                                                          = value,
                                                    )),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                )),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                    child: Text(
                                  'Select',
                                  style: GoogleFonts.kameron(
                                      fontSize: 15, color: Color(0xff812ac7)),
                                )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "$pday days",
                      style: GoogleFonts.kameron(
                          fontSize: 15, color: Color(0xffbc84e9)),
                    )),
              ),
             SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 30,),
                  Icon(Icons.calendar_month_outlined,color: Colors.grey[400],size: 40,),
                  SizedBox(width: 20,),
                  Text('Notify about the start of \nthe period',
                    style:
                    GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),),
                  SizedBox(width: 40,),
                  GestureDetector(
                    onTap: () {
                      // Toggle the visibility of the tick icon
                      setState(() {
                        isCTickVisible = !isCTickVisible;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffbc84e9),
                          ),
                        ),
                        if (isCTickVisible)
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  SizedBox(width: 30,),
                  Icon(Icons.circle_outlined,color: Colors.grey[400],size: 40,),
                  SizedBox(width: 20,),
                  Text('Notify about the start of \nthe ovulation',
                    style:
                    GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),),
                  SizedBox(width: 40,),
                  GestureDetector(
                    onTap: () {
                      // Toggle the visibility of the tick icon
                      setState(() {
                        isPTickVisible = !isPTickVisible;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffbc84e9),
                          ),
                        ),
                        if (isPTickVisible)
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Text('Theme',
                style:
                GoogleFonts.kameron(color: Colors.black, fontSize: 20),),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
