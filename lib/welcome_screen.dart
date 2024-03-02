import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:luna_loom/utils/dimensions.dart';
import 'package:luna_loom/utils/lu_colors.dart';
import 'package:luna_loom/widgets/logo_widget.dart';
import 'package:luna_loom/widgets/lu_font_txt.dart';

import 'average_cycle.dart';
class LuWelcome extends StatefulWidget {
  const LuWelcome({super.key});

  @override
  State<LuWelcome> createState() => _LuWelcomeState();
}

class _LuWelcomeState extends State<LuWelcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            Container(
              margin: EdgeInsets.only(top: Dimensions.height60),
              child: LuFontText(text: 'Welcome!',size: Dimensions.font30,),
            ),
            Container(
              margin: EdgeInsets.only(top: Dimensions.height10),
              child: Column(
                children: [
                  LuFontText(text: 'Please answer a few questions and we will',size: Dimensions.font12,),
                  LuFontText(text: 'Personalize the app for you',size: Dimensions.font12,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Dimensions.height60),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius25)
                    ),
                    backgroundColor: LuColors.textWhiteColor,
                      elevation: 3, minimumSize: Size(Dimensions.width220, Dimensions.height50),),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,a1,a2){
                      return const AvgCycle();
                    },
                        transitionsBuilder: (context,an1,an2,child){
                          return FadeTransition(opacity: an1,child: child,);
                        },
                        transitionDuration: const Duration(milliseconds: 200)));
                  },
                  child: const LuFontText(text: "Continue",color: LuColors.textPurpleColor,)),
            ),
            Container(
              margin: EdgeInsets.only(top: Dimensions.height20),
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
              bottom: Dimensions.height10),
              child: Center(
                  child: Column(
                    children: [
                      Text.rich(TextSpan(
                          text: "By tapping \"Continue\" you agree to our ",
                          style: TextStyle(
                              fontSize: Dimensions.font10,
                              fontFamily: 'Kameron',
                              color: LuColors.textGreyColor),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'terms of Service',
                                style: TextStyle(
                                    fontSize: Dimensions.font10,
                                    fontFamily: 'Kameron',
                                    color: LuColors.textGreyColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: LuColors.textGreyColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // print("Terms Of Service");
                                  }),
                          ])),
                      Text.rich(TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            fontSize: Dimensions.font10,
                            fontFamily: 'Kameron',
                            color: LuColors.textGreyColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'privacy policy',
                                style: TextStyle(
                                    fontSize: Dimensions.font10,
                                    fontFamily: 'Kameron',
                                    color: LuColors.textGreyColor,
                                    decoration: TextDecoration.underline,
                                    decorationColor: LuColors.textGreyColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // print("Privacy Policy");
                                  })
                          ]))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}