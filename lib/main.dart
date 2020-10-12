// Main file for the app

import 'package:draw_it_app/LogInSignUpSwitcher.dart';
import 'package:draw_it_app/LoginPage.dart';
import 'package:draw_it_app/SignUpPage.dart';
import 'package:draw_it_app/initialScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Forcing the layout to be portrait
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
      title: "Draw It",
      home: email == null ? LogInSignUpSwitcher() : SplashScreen()));
}
