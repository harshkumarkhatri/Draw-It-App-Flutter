import 'dart:async';

import 'package:draw_it_app/del_screenshot_test.dart';
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
            MaterialPageRoute(builder: (_) => ScreenShotCapture()))
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color.fromRGBO(168, 196, 208, 1), Colors.green[400]],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        // TODO: Add the desired gif file here
        child: Image.network(
            "https://media.giphy.com/media/KGSI32IXP5IbXoKSV4/giphy.gif"),
      ),
    );
  }
}
