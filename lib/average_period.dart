import 'package:flutter/material.dart';
import 'package:luna_loom/previous_menses.dart';
import 'package:luna_loom/utils/dimensions.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:luna_loom/widgets/logo_widget.dart';
import 'package:luna_loom/widgets/lu_font_txt.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class Avg_Period extends StatefulWidget {

  const Avg_Period({super.key});

  @override
  State<Avg_Period> createState() => _Avg_PeriodState();
}

class _Avg_PeriodState extends State<Avg_Period> {
  var avgprd = 5;
  late SharedPreferences preferences;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            SizedBox(
              height: Dimensions.height30,
            ),
            const LuFontText(text: 'How long does your period last'),
           const LuFontText(text: 'on average?'),
            SizedBox(
              height: Dimensions.height20,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width15, vertical: Dimensions.height15),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.height15),
                  alignment: Alignment.center,
                  height: Dimensions.height40,
                  decoration: BoxDecoration(
                      color: LuColors.textWhiteColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                            color: LuColors.textPurpleColor,
                            blurRadius: 5,
                            spreadRadius: .5)
                      ]),
                ),
                Positioned(
                    child: Container(
                  height: Dimensions.height50,
                  width: Dimensions.width50,
                  decoration: BoxDecoration(
                      color: LuColors.textWhiteColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius50),
                      boxShadow: [
                        BoxShadow(
                            color: LuColors.textPurpleColor,
                            blurRadius: 10,
                            spreadRadius: .5)
                      ]),
                )),
                NumberPicker(
                    haptics: true,
                    minValue: 1,
                    maxValue: 20,
                    value: avgprd,
                    itemHeight: 45,
                    itemWidth: 45,
                    itemCount: 7,
                    axis: Axis.horizontal,
                    selectedTextStyle: TextStyle(
                      color: LuColors.textPurpleColor,
                      fontSize: 25,
                    ),
                    textStyle:
                        TextStyle(color: LuColors.textlightPurpleColor, fontSize: 15),
                    onChanged: (value) {setState(
                          () {
                            avgprd = value;
                            Vibration.vibrate(duration: 10,);
                          }
                        );}),
              ],
            ),
            SizedBox(height: Dimensions.height5,),
            LuFontText(text: 'days',size: Dimensions.font15,),
            SizedBox(height: Dimensions.height30,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LuColors.textWhiteColor,
                      elevation: 3, minimumSize: Size(Dimensions.width220, Dimensions.height50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),
                  ),
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
                        transitionDuration: const Duration(milliseconds: 200)));
                  },
                  child: LuFontText(text: 'Continue',color: LuColors.textPurpleColor,)),
            SizedBox(height: Dimensions.height10,),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LuColors.textWhiteColor,
                      elevation: 3, minimumSize: Size(Dimensions.width220, Dimensions.height50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),),
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
                        transitionDuration: const Duration(milliseconds: 200)));
                  },
                  child: LuFontText(text: "I don't remember",size: Dimensions.font15,color: LuColors.textlightPurpleColor,)),
          ],
        ),
      ),
    );
  }
}
