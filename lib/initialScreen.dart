// This file has the code related to Initial Screen which displays the GIF

import 'dart:async';

import 'package:draw_it_app/myHomePage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => ScreenShotCapture())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset("assets/loadingGIF.gif"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Text("Draw It",
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient)),
                ),
              ],
            ),
          ],
        ));
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.white, Colors.blue[300]],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
