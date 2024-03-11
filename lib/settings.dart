import 'package:flutter/material.dart';
import 'package:luna_loom/home_screen.dart';
import 'package:luna_loom/utils/dimensions.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:luna_loom/welcome_screen.dart';
import 'package:luna_loom/widgets/lu_font_txt.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
class LuSettings extends StatefulWidget {
  const LuSettings({super.key});

  @override
  State<LuSettings> createState() => _LuSettingsState();
}

class _LuSettingsState extends State<LuSettings> {
  late SharedPreferences preferences;
  int avgCyc = 28;
  int avgPrd =8;
  bool isANewUser = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      avgCyc = preferences.getInt("AvgCycle")!;
      avgPrd = preferences.getInt("AvgPeriod")!;
    });
  }

  bool isCTickVisible = false;
  bool isPTickVisible = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: LuColors.textWhiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context,a1,a2){
                  return const HomeScreen();
                },
                    transitionsBuilder: (context,an1,an2,child){
                      return FadeTransition(opacity: an1,child: child,);
                    },
                    transitionDuration: const Duration(milliseconds: 800)));
              },
              icon:  Icon(Icons.arrow_back,size: Dimensions.iconSize20,)),
          centerTitle: true,
          title: const LuFontText(text: 'Settings',color: Colors.black,),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimensions.height50,
              ),
              LuFontText(text: 'Duration of cycle',size: Dimensions.font15,color: Colors.grey[600],),
              SizedBox(
                height: Dimensions.height10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LuColors.textWhiteColor,
                      elevation: 1, minimumSize: Size(Dimensions.width300, Dimensions.height40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                              margin: EdgeInsets.only(top: Dimensions.height20),
                              child: SizedBox(
                                height: Dimensions.height200,
                                child: StatefulBuilder(
                                    builder: (context, setState) {
                                  return Column(
                                    children: <Widget>[
                                      LuFontText(text: 'Duration of cycle',color: Colors.grey[600],size: Dimensions.font15,),
                                      LuFontText(text: 'Choose the number of days',color: Colors.grey[600],size: Dimensions.font15,),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width5, vertical: Dimensions.height15),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width15),
                                            alignment: Alignment.center,
                                            height: Dimensions.height30,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(Dimensions.radius20),
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          NumberPicker(
                                            //haptics: true,
                                              minValue: 20,
                                              maxValue: 50,
                                              value: avgCyc,
                                              itemHeight: Dimensions.height30,
                                              itemWidth: Dimensions.width30,
                                              itemCount: 5,
                                              axis: Axis.vertical,
                                              selectedTextStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: Dimensions.font25,
                                              ),
                                              textStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: Dimensions.font15),
                                              onChanged: (value) {
                                                //HapticFeedback.heavyImpact();
                                                Vibration.vibrate(duration: 10,);
                                                setState(() {
                                                  avgCyc = value;
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
                                  preferences.setInt("AvgCycle", avgCyc);
                                });
                                if (context.mounted) Navigator.of(context).pop();
                              },
                              child: Center(
                                  child: LuFontText(text: 'Select',size: Dimensions.font15,color: LuColors.textPurpleColor,)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: LuFontText(text: "$avgCyc days",size: Dimensions.font15,color: LuColors.textLightPurpleColor,)),
              SizedBox(
                height: Dimensions.height20,
              ),
              LuFontText(text: 'Duration of period',size: Dimensions.font15,color: Colors.grey[600],),
              SizedBox(
                height: Dimensions.height10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1, minimumSize: Size(Dimensions.width300, Dimensions.height40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                              margin: EdgeInsets.only(top: Dimensions.height20),
                              child: SizedBox(
                                height: Dimensions.height200,
                                child: StatefulBuilder(
                                    builder: (context, setState) {
                                  return Column(
                                    children: <Widget>[
                                      LuFontText(text: 'Duration of period',size: Dimensions.font15,color: Colors.grey[600],),
                                      LuFontText(text: 'Choose the number of days',size: Dimensions.font15,color: Colors.grey[600],),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width5, vertical: Dimensions.height15),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions.width15),
                                            alignment: Alignment.center,
                                            height: Dimensions.height30,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(Dimensions.radius20),
                                              border: Border.all(
                                                  color: Colors.grey.shade200),
                                            ),
                                          ),
                                          NumberPicker(
                                              haptics: true,
                                              minValue: 1,
                                              maxValue: 20,
                                              value: avgPrd,
                                              itemHeight: Dimensions.height30,
                                              itemWidth: Dimensions.width30,
                                              itemCount: 5,
                                              axis: Axis.vertical,
                                              selectedTextStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: Dimensions.font25,
                                              ),
                                              textStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: Dimensions.font15),
                                              onChanged: (value)  {setState(
                                                    ()  {
                                                      avgPrd = value;
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
                                  preferences.setInt("AvgPeriod", avgPrd);
                                });
                                if (context.mounted) Navigator.of(context).pop();
                              },
                              child: Center(
                                  child: LuFontText(text: 'Select',size: Dimensions.font15,color: LuColors.textPurpleColor,)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: LuFontText(text: "$avgPrd days",size: Dimensions.font15,color: LuColors.textLightPurpleColor,)),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey[400],
                      size: Dimensions.iconSize40,
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    LuFontText(text: 'Notify about the start of \nthe period',
                    size: Dimensions.font15,color: Colors.grey[600],),
                    SizedBox(
                      width: Dimensions.width40,
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
                            width: Dimensions.width40,
                            height: Dimensions.height40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: LuColors.textLightPurpleColor,
                            ),
                          ),
                          if (isCTickVisible)
                            Icon(
                              Icons.check,
                              color: LuColors.textWhiteColor,
                              size: Dimensions.iconSize20,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      color: Colors.grey[400],
                      size: Dimensions.iconSize40,
                    ),
                    SizedBox(
                      width: Dimensions.width20,
                    ),
                    LuFontText(text: 'Notify about the start of \nthe ovulation',color: Colors.grey[600],size: Dimensions.font15,),
                    SizedBox(
                      width: Dimensions.width40,
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
                            width: Dimensions.width40,
                            height: Dimensions.height40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: LuColors.textLightPurpleColor,
                            ),
                          ),
                          if (isPTickVisible)
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: Dimensions.iconSize20,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              const LuFontText(text: 'Theme',color: Colors.black,),
              SizedBox(
                height: Dimensions.height20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1, minimumSize: Size(Dimensions.width150, Dimensions.height40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),),
                  onPressed: () async {
                    preferences = await SharedPreferences.getInstance();
                    preferences.setBool('newUser', false);

                    ///change to false
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(pageBuilder: (context,a1,a2){
                      return const LuWelcome();
                    },
                        transitionsBuilder: (context,an1,an2,child){
                          return FadeTransition(opacity: an1,child: child,);
                        },
                        transitionDuration: const Duration(milliseconds: 100)));
                    }
                  },
                  child: const LuFontText(text: 'Logout',color: LuColors.textPurpleColor,)),

            ],
          ),
        ),
    );
  }
}
