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

  _Lu_SettingsState({required this.avgcyc, required this.avgprd});


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
                                  height: 150,
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Column(
                                      children: <Widget>[
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
                                                value: widget.avgcyc,
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
                                                          widget.avgcyc = value,
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
                                      fontSize: 15, color: Color(0xffbc84e9)),
                                )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "${widget.avgcyc} days",
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
                                  height: 150,
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Column(
                                      children: <Widget>[
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
                                                value: widget.avgprd,
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
                                                          widget.avgprd = value,
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
                                      fontSize: 15, color: Color(0xffbc84e9)),
                                )),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "${widget.avgprd} days",
                      style: GoogleFonts.kameron(
                          fontSize: 15, color: Color(0xffbc84e9)),
                    )),
              ),
              Text('${widget.avgcyc}'),
              Text('${widget.avgprd}')
            ],
          ),
        ),
      ),
    );
  }
}
