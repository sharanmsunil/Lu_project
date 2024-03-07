import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class AnimationFlow extends StatefulWidget {
  const AnimationFlow({super.key});

  @override
  _AnimationFlowState createState() => _AnimationFlowState();
}

class _AnimationFlowState extends State<AnimationFlow>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late Animation<double> animation1;

  late AnimationController controller2;
  late Animation<double> animation2;

  late AnimationController controller3;
  late Animation<double> animation3;

  late AnimationController controller4;
  late Animation<double> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation1 = Tween<double>(begin: 1.9, end: 2.1)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });

    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation2 = Tween<double>(begin: 1.8, end: 2.4)
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });

    controller3 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation3 = Tween<double>(begin: 1.8, end: 2.4)
        .animate(CurvedAnimation(parent: controller3, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller3.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller3.forward();
        }
      });

    controller4 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation4 = Tween<double>(begin: 1.9, end: 2.1)
        .animate(CurvedAnimation(parent: controller4, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller4.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller4.forward();
        }
      });

    controller4.forward();

    Timer(Duration(milliseconds: 800), () {
      controller3.forward();
    });
    //
    Timer(Duration(milliseconds: 1600), () {
      controller2.forward();
    });
    //
    Timer(Duration(milliseconds: 2000), () {
      controller1.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: Image.asset('assets/Lu/logo.png', height: 200, width: 200,),
          ),
          CustomPaint(
            painter: MyPainter(animation1.value, animation2.value,
                animation3.value, animation4.value),
            child: SizedBox(
              height: h,
              width: w,
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double h1;
  final double h2;
  final double h3;
  final double h4;

  MyPainter(this.h1, this.h2, this.h3, this.h4);

  @override
  void paint(Canvas canvas,  size) {
    var paint = Paint();
    paint
      ..color = Colors.blue.withOpacity(.7)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height / h1);

    path.cubicTo(size.width * .4, size.height / h2, size.width * .7,
        size.height / h3, size.width, size.height / h4);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}