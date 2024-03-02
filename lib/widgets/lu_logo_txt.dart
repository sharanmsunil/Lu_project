

import 'package:flutter/material.dart';
import 'package:luna_loom/utils/dimensions.dart';
class LuLogoText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  const LuLogoText({super.key,
    required this.color,
    required this.text,
    this.size = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'KolkerBrush',
        color: color,
        fontSize: size == 0 ? Dimensions.font130:size,
      ),
    );
  }
}
