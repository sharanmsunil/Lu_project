import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_loom/home_screen.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:luna_loom/welcome_screen.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/services.dart';
class Lu_Settings extends StatefulWidget {
  Lu_Settings({super.key});

  @override
  State<Lu_Settings> createState() => _Lu_SettingsState();
}

class _Lu_SettingsState extends State<Lu_Settings> {
  late SharedPreferences preferences;
  int avgcyc = 28;
  int avgprd =8;
  bool isANewUser = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgcyc = preferences.getInt("AvgCycle")!;
      avgprd = preferences.getInt("AvgPeriod")!;
    });
  }

  //var cday =28;
  //var pday =5;

  bool isCTickVisible = false;
  bool isPTickVisible = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: LuColors.textWhiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context,a1,a2){
                          return Home_Screen();
                        },
                            transitionsBuilder: (context,an1,an2,child){
                              return FadeTransition(opacity: an1,child: child,);
                            },
                            transitionDuration: Duration(milliseconds: 800)));
                      },
                      icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    'Settings',
                    style:
                        GoogleFonts.kameron(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Duration of cycle',
                style:
                    GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LuColors.textWhiteColor,
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
                                        style: GoogleFonts.kameron(
                                            color: Colors.grey[600],
                                            fontSize: 15),
                                      ),
                                      Text(
                                        'Choose the number of days',
                                        style: GoogleFonts.kameron(
                                            color: Colors.grey[600],
                                            fontSize: 15),
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
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          NumberPicker(
                                            //haptics: true,
                                              minValue: 20,
                                              maxValue: 50,
                                              value: avgcyc,
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
                                              onChanged: (value) {
                                                //HapticFeedback.heavyImpact();
                                                Vibration.vibrate(duration: 10,);
                                                setState(() {
                                                  avgcyc = value;
                                                });
                                              }),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              )),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                preferences =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  preferences.setInt("AvgCycle", avgcyc);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Center(
                                  child: Text(
                                'Select',
                                style: GoogleFonts.kameron(
                                    fontSize: 15, color: LuColors.textPurpleColor),
                              )),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "$avgcyc days",
                    style: GoogleFonts.kameron(
                        fontSize: 15, color: LuColors.textlightPurpleColor),
                  )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Duration of period',
                style:
                    GoogleFonts.kameron(color: Colors.grey[600], fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
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
                                        style: GoogleFonts.kameron(
                                            color: Colors.grey[600],
                                            fontSize: 15),
                                      ),
                                      Text(
                                        'Choose the number of days',
                                        style: GoogleFonts.kameron(
                                            color: Colors.grey[600],
                                            fontSize: 15),
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
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          NumberPicker(
                                              haptics: true,
                                              minValue: 1,
                                              maxValue: 20,
                                              value: avgprd,
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
                                              onChanged: (value)  {setState(
                                                    ()  {
                                                      avgprd = value;
                                                      Vibration.vibrate(duration: 10,);
                                                    }

                                                  );}),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              )),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                preferences =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  preferences.setInt("AvgPeriod", avgprd);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Center(
                                  child: Text(
                                'Select',
                                style: GoogleFonts.kameron(
                                    fontSize: 15, color: LuColors.textPurpleColor),
                              )),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "$avgprd days",
                    style: GoogleFonts.kameron(
                        fontSize: 15, color: LuColors.textlightPurpleColor),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey[400],
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Notify about the start of \nthe period',
                    style: GoogleFonts.kameron(
                        color: Colors.grey[600], fontSize: 15),
                  ),
                  SizedBox(
                    width: 40,
                  ),
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
                            color: LuColors.textlightPurpleColor,
                          ),
                        ),
                        if (isCTickVisible)
                          Icon(
                            Icons.check,
                            color: LuColors.textWhiteColor,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.circle_outlined,
                    color: Colors.grey[400],
                    size: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Notify about the start of \nthe ovulation',
                    style: GoogleFonts.kameron(
                        color: Colors.grey[600], fontSize: 15),
                  ),
                  SizedBox(
                    width: 40,
                  ),
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
                            color: LuColors.textlightPurpleColor,
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
              SizedBox(
                height: 20,
              ),
              Text(
                'Theme',
                style: GoogleFonts.kameron(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1, minimumSize: Size(150, 40)),
                  onPressed: () async {
                    preferences = await SharedPreferences.getInstance();
                    preferences.setBool('newUser', false);

                    ///change to false
                    Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context,a1,a2){
                      return Lu_Welcome();
                    },
                        transitionsBuilder: (context,an1,an2,child){
                          return FadeTransition(opacity: an1,child: child,);
                        },
                        transitionDuration: Duration(milliseconds: 100)));
                  },
                  child: Text(
                    'Logout',
                    style: GoogleFonts.kameron(
                        fontSize: 20, color: LuColors.textPurpleColor),
                  )),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
    );
  }
}
