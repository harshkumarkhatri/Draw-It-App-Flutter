// This file has the code related to the main home screen for the app which consists of the drawing screen

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draw_it_app/LogInSignUpSwitcher.dart';
import 'package:draw_it_app/aboutTheDeveloper.dart';
import 'package:draw_it_app/ImagesGridview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'colorPalette.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(ScreenShotCapture());

class ScreenShotCapture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Screenshot Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();

  AnimationController controller;
  List<Offset> points = <Offset>[];
  Color color = Colors.black;
  StrokeCap strokeCap = StrokeCap.round;
  double strokeWidth = 5.0;
  List<Painter> painterList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  bool _saveTo = false;
  var email, uid, imageUrl;

  // Auth for firebase authentications
  final FirebaseAuth auth = FirebaseAuth.instance;
  // var firebaseUser=auth.currentUser;

  // List which will store the list in the database
  List li;
  dynamic imageURLS;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    init();
  }

// Getting the initial value of the _saveTo, prefs, email, uid variable and setting other variables accordingly
  void init() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    uid = prefs.getString('uid');
    _saveTo = prefs.getBool('_saveTo') ?? false;
    setState(() {
      if (email == null) {
        _saveTo = true;
      }
      _saveTo;
      if (uid != null) {
        folderName = uid;
      }
    });
    var firebaseUser = auth.currentUser;
    firestoreInstance
        .collection("ImageLinks")
        .document(firebaseUser.uid)
        .get()
        .then((value) {});
  }

  // Initializing a firestore instance.
  final firestoreInstance = Firestore.instance;

  // Showing snackbar
  void showInSnackBar(text) {
    print(text);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  final _imageSave = ImageSaver();
  GlobalKey _repaintKey = GlobalKey();
  StorageReference storageReference = FirebaseStorage().ref();
  bool isSwitched = false;
  bool loading = false;
  var forClear = "save";
  var loc;

  String folderName;
  static FirebaseDatabase fb = FirebaseDatabase.instance;
  DatabaseReference ref = fb.reference();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users =
      FirebaseFirestore.instance.collection("ImageLinks");

  // Converting the screen to image and saving on cloud or storage
  void convertWidgetToImage() async {
    RenderRepaintBoundary renderRepaintBoundary =
        _repaintKey.currentContext.findRenderObject();
    ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
    ByteData bytedata =
        await boxImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List iInt8List = bytedata.buffer.asUint8List();
    this.setState(() {
      loading = true;
      loc = "$folderName/IMG_${DateTime.now()}.png";
    });

    // Saving the screen
    if (forClear == "save") {
      // Saving the screen to Storage
      if (_saveTo) {
        final res = await _imageSave.saveImage(
            imageBytes: iInt8List, directoryName: "Draw It");
        // print("res is ${res}");
        print("saving to gallery");
        showInSnackBar(
            "Image Saved to Gallery. Start drawing to auto clear screen.");
      }

      // Saving the screen to Cloud.
      else {
        StorageUploadTask storageUploadTask =
            storageReference.child(loc).putData(iInt8List);
        await storageUploadTask.onComplete;
        storageReference.child(loc).getDownloadURL().then(
          (url) {
            setState(
              () {
                print("url is $url");
                imageUrl = url;
                print("Image url is ${imageURLS.toString()}");
                print("Email is $email");

                // This will be updating and adding the link of new saved image to the firestore database which was initialized after successful signup.
                users.document(uid).updateData(
                  {
                    "links": FieldValue.arrayUnion([url])
                  },
                );
              },
            );
          },
        );
        print("Saving to cloud");
        print("imge url is ${imageUrl}");

        // Showing a message when image saved to cloud.
        showInSnackBar("Image saved to Cloud.");
      }
    }

    // Circular progress indicator will be displayed until the image is saved.
    CircularProgressIndicator();

    // For clearing the Screen and displaying a message with snackbar.
    if (forClear != "save") {
      WidgetsBinding.instance.addPostFrameCallback((_) => showInSnackBar(
          "Cleared in backend. Start drawing to hve an empty screen."));
    }
    painterList.clear();
    points.clear();
    this.setState(() {
      forClear = "save";
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Displaying a pop-up screen on clicking back to exit the app.
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            // Displaying an alert message on basis of coloured pixels on screen.
            return AlertDialog(
              content: painterList.isEmpty && points.isEmpty
                  ? Text('Are you sure you want to exit?')
                  : Text(
                      "Are you sure you want to exit? All progress will be lost"),

              // Actions displayed when we click back to exit the app.
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes, exit'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        return value == true;
      },
      child: Scaffold(
        key: _scaffoldKey,

        // Switching between circular progress bar indicator and stack
        body: !loading
            ? Stack(
                children: [
                  // Screen on which drawings are made.
                  RepaintBoundary(
                    key: _repaintKey,
                    child: Container(
                      color: Colors.white,
                      child: new GestureDetector(
                        onPanUpdate: (DragUpdateDetails details) {
                          setState(() {
                            RenderBox object = context.findRenderObject();
                            Offset localPosition =
                                object.globalToLocal(details.globalPosition);
                            points = new List.from(points);
                            points.add(localPosition);
                          });
                        },
                        onPanEnd: (DragEndDetails details) => points.add(null),
                        child: CustomPaint(
                          painter: Painter(
                              points: points,
                              color: color,
                              strokeCap: strokeCap,
                              strokeWidth: strokeWidth,
                              painters: painterList),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ),

                  // Top 3 dots
                  Positioned(
                    top: 45,
                    right: 0,
                    child: FlatButton(
                      onPressed: () {
                        print("pressing");
                      },
                      child: PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {
                            'About The Developer',
                            email != null
                                ? (_saveTo
                                    ? "Save to Cloud"
                                    : "Save to Storage")
                                : "Save to Storage",
                            'Images Saved to Cloud',
                            'Quick Exit',
                            email == null ? "Log In" : "Log Out",
                          }.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ],
              )
            :
            //Displayed when image is being saved.
            Center(child: CircularProgressIndicator()),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Clear Floating action button
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: controller,
                  curve:
                      Interval(0.0, 1.0 - 0 / 3 / 2.0, curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: "Clear",
                  mini: true,
                  child: Icon(Icons.clear),
                  onPressed: () {
                    forClear = "!save";
                    convertWidgetToImage();
                    points.clear();
                    painterList.clear();
                  },
                ),
              ),
            ),

            // Erase Floating action button
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: controller,
                  curve:
                      Interval(0.0, 1.0 - 1 / 3 / 2.0, curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: "Erase",
                  mini: true,
                  child: FaIcon(FontAwesomeIcons.eraser),
                  onPressed: () {
                    Color temp;
                    temp = Colors.white;
                    if (temp != null) {
                      setState(() {
                        painterList.add(Painter(
                            points: points.toList(),
                            color: color,
                            strokeCap: strokeCap,
                            strokeWidth: strokeWidth));
                        points.clear();
                        strokeCap = StrokeCap.round;
                        strokeWidth = 5.0;
                        color = temp;
                      });
                    }
                  },
                ),
              ),
            ),

            // Draw Floating action button
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: controller,
                  curve:
                      Interval(0.0, 1.0 - 1 / 3 / 2.0, curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: "Draw",
                  mini: true,
                  child: Icon(Icons.brush),
                  onPressed: () {
                    Color temp;
                    temp = Colors.black;
                    if (temp != null) {
                      setState(
                        () {
                          painterList.add(Painter(
                              points: points.toList(),
                              color: color,
                              strokeCap: strokeCap,
                              strokeWidth: strokeWidth));
                          points.clear();
                          strokeCap = StrokeCap.round;
                          strokeWidth = 5.0;
                          color = temp;
                        },
                      );
                    }
                  },
                ),
              ),
            ),

            // Change Colors Floating Action Button
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: controller,
                  curve:
                      Interval(0.0, 1.0 - 2 / 3 / 2.0, curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: "Change Color",
                  mini: true,
                  child: Icon(
                    Icons.color_lens,
                  ),
                  onPressed: () async {
                    Color temp;
                    temp = await showDialog(
                        context: context, builder: (context) => ColorDialog());
                    if (temp != null) {
                      setState(
                        () {
                          painterList.add(Painter(
                              points: points.toList(),
                              color: color,
                              strokeCap: strokeCap,
                              strokeWidth: strokeWidth));
                          points.clear();
                          strokeCap = StrokeCap.round;
                          strokeWidth = 5.0;
                          color = temp;
                        },
                      );
                    }
                  },
                ),
              ),
            ),

            // Save Floating Action Button
            Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: controller,
                  curve:
                      Interval(0.0, 1.0 - 2 / 3 / 2.0, curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: "Save",
                  mini: true,
                  child: Icon(
                    Icons.save_alt,
                  ),
                  onPressed: () async {
                    convertWidgetToImage();
                  },
                ),
              ),
            ),

            // Main Floating Action Button
            FloatingActionButton(
              heroTag: null,
              tooltip: "Open Drawer",
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    transform:
                        Matrix4.rotationZ(controller.value * 0.5 * 3.1415),
                    alignment: FractionalOffset.center,
                    child: Icon(Icons.brush),
                  );
                },
              ),
              onPressed: () {
                if (controller.isDismissed) {
                  controller.forward();
                } else {
                  controller.reverse();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

// Open the page respective to the choice from top 3 dots
  void handleClick(String value) {
    switch (value) {
      // Opens the About the Developer page
      case 'About The Developer':
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AboutTheDev()));
        break;

      // Opens the Images saved to cloud page where images are displayed in form of GridView.
      case 'Images Saved to Cloud':
        email != null
            ? Navigator.push(
                context, MaterialPageRoute(builder: (_) => ImagesGridView()))
            : showInSnackBar(
                "You need to login and Save images to Cloud to access this. Images Saved to Local Storage Can be found in Gallery.");
        break;

      // Switches the _saveTo variable so that screens are saved in cloud.
      case 'Save to Cloud':
        print("Printinh inside save to cloud ${_saveTo}");
        setState(() {
          _saveTo = !_saveTo;
        });
        prefs.setBool('_saveTo', _saveTo);
        showInSnackBar("Your drawings will be saved to Cloud");
        break;

      // Switches the _saveTo variable so that screens are saved in storage.
      case 'Save to Storage':
        print("Printinh inside save to storage ${_saveTo}");
        setState(() {
          email == null ? _saveTo = true : _saveTo = !_saveTo;
        });
        prefs.setBool('_saveTo', _saveTo);
        showInSnackBar("Your drawings will be saved to Internal Storage");
        break;

      // Exits the app directly.
      case 'Quick Exit':
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        break;

      // Pops out the drawing pad screen and pops in the login signup switcher screen
      case 'Log In':
        {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => LogInSignUpSwitcher()));
        }

        break;

      //  Setting the Shared prefrence values to null with popping an screen and pushing the login signup switcher screen
      case 'Log Out':
        {
          prefs.setString('email', null);
          prefs.setString('uid', null);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => LogInSignUpSwitcher()));
        }

        break;
    }
  }
}

// For painting on the screen
class Painter extends CustomPainter {
  List<Offset> points;
  Color color;
  StrokeCap strokeCap;
  double strokeWidth;
  List<Painter> painters;

  Painter({
    this.points,
    this.color,
    this.strokeCap,
    this.strokeWidth,
    this.painters = const [],
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (Painter painter in painters) {
      painter.paint(canvas, size);
    }

    Paint paint = new Paint()
      ..color = color
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => oldDelegate.points != points;
}
