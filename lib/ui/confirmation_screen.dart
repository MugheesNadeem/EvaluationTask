import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/size_config.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF181C1F),
      child: Column(
          children: [
            ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                color: Color(0xFF1DC3A7),
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/finger.png',
                      height: 300,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'YAYYY!',
                      style: TextStyle(
                        fontFamily: 'BarlowCondensed',
                        fontSize: 34
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Text(
                'Success',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'We\'re open in your area!',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ]
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 0.4;

    // this is top part of path, rectangle without any rounding
    final filledRectangle =
    Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -5, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
