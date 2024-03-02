import 'package:flutter/material.dart';
import 'package:luna_loom/utils/dimensions.dart';
import 'package:luna_loom/widgets/lu_font_txt.dart';
import 'package:luna_loom/widgets/lu_logo_txt.dart';

import '../utils/lu_colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height300,
      width: double.maxFinite,
      child: Stack(alignment: Alignment.center, children: [
        Positioned(
          top: Dimensions.height50,
          child: SizedBox(
            height: Dimensions.height150,
            width: Dimensions.height150,
            child: Image.asset(
              'assets/Lu/logo.png',
            ),
          ),
        ),
        Positioned(
          top: Dimensions.height30,
          child: LuLogoText(color: LuColors.logoColor, text: 'Lu'),
        ),
        Positioned(bottom: Dimensions.height45, child: LuFontText(text: 'LunaLoom',size: Dimensions.font45,)),
        Positioned(
            bottom: Dimensions.height40,
            child: LuFontText(
              text: 'Illuminate Your Monthly Rhythm',
              size: Dimensions.font10,
            )),
      ]),
    );
  }
}
