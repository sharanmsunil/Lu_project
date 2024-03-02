import 'package:flutter/material.dart';
import 'package:luna_loom/utils/dimensions.dart';
class LuFontText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  LuFontText({
    this.color =  Colors.white,
    required this.text,
    this.size = 0,
});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Kameron',
        color: color,
        fontSize: size == 0 ? Dimensions.font20:size,
      ),
    );
  }
}
