// // Try 2
// import 'package:draw_it_app/del_screenshot_test.dart';
// import 'package:draw_it_app/initialScreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signature_pad/flutter_signature_pad.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MaterialApp(home: SplashScreen()));
// }

// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   SharedPreferences prefs = await SharedPreferences.getInstance();
// //   var email = prefs.getString('email');
// //   runApp(
// //       MaterialApp(home: email == null ? LoginScreen() : ScreenShotCapture()));
// // }

import 'package:draw_it_app/LogInSignUpSwitcher.dart';
import 'package:draw_it_app/LoginPage.dart';
import 'package:draw_it_app/SignUpPage.dart';
import 'package:draw_it_app/initialScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LogInSignUpSwitcher(),
//     );
//   }
// }

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
      home: email == null ? LogInSignUpSwitcher() : SplashScreen()));
}
