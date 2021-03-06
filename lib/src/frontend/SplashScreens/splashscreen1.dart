import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motivation_quotes/src/AppConfigurations/Colors.dart';
import 'dart:math' as math;

import 'package:motivation_quotes/src/AppConfigurations/constants.dart';

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      value: 0.0,
      duration: Duration(seconds: 3),
      upperBound: 1,
      lowerBound: -1,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: DrawCLip(animationController.value),
                      child: Container(
                        height: size.height * 0.5,
                        
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [Colors.teal, Colors.purple])),
                      ),
                    );
                  }),
              Container(
                height: size.height * 0.5,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.accessibility_new,
                    size: 75,
                    color: kIconColor,
                  ),
                ),
              )
            ],
          ),
          CupertinoButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, ksplashScreen2);
              },
              child: Text('Get Started'))
        ],
      ),
    );
  }
}



















class DrawCLip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawCLip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    var x = size.width;
    var y = size.height;
    var centerY = y + math.cos(move * slice);
    var centerX = x / 2 + x * math.sin(move * slice);
    path.lineTo(0, y * 0.6);
    path.quadraticBezierTo(centerX, centerY, x, y * 0.8); 
    path.lineTo(x, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
