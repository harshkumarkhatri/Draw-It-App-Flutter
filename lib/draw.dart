// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:screenshot/screenshot.dart';
// import 'colorPalette.dart';
// import 'draw.dart';

// void main() => runApp(ScreenShotCapture());

// class ScreenShotCapture extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Screenshot Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   int _counter = 0;
//   File _imageFile;

//   ScreenshotController screenshotController = ScreenshotController();

//   AnimationController controller;
//   List<Offset> points = <Offset>[];
//   Color color = Colors.black;
//   StrokeCap strokeCap = StrokeCap.round;
//   double strokeWidth = 5.0;
//   List<Painter> painterList = [];
//   ByteData _img = ByteData(0);
//   String snackbar = "Cleared in backend. Drawing will have an empty screen";
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   void showInSnackBar() {
//     print(snackbar);
//     _scaffoldKey.currentState.showSnackBar(
//       SnackBar(
//         content: Text(snackbar),
//       ),
//     );
//   }

//   GlobalKey _repaintKey = GlobalKey();
//   StorageReference storageReference = FirebaseStorage().ref();
//   bool loading = false;
//   var forClear = "save";
//   void convertWidgetToImage() async {
//     RenderRepaintBoundary renderRepaintBoundary =
//         _repaintKey.currentContext.findRenderObject();
//     ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
//     ByteData bytedata =
//         await boxImage.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List iInt8List = bytedata.buffer.asUint8List();
//     this.setState(() {
//       loading = true;
//     });
//     print("initial value of save ${forClear}");
//     if (forClear == "save") {
//       StorageUploadTask storageUploadTask = storageReference
//           .child("IMG_${DateTime.now().millisecondsSinceEpoch}.png")
//           .putData(iInt8List);
//       await storageUploadTask.onComplete;
//     }
//     if (forClear != "save") {
//       WidgetsBinding.instance.addPostFrameCallback((_) => showInSnackBar());
//     }
//     painterList.clear();
//     points.clear();
//     this.setState(() {
//       forClear = "save";
//       loading = false;
//     });
//     print("final value of save ${forClear}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: !loading
//           ? RepaintBoundary(
//               key: _repaintKey,
//               child: Container(
//                 color: Colors.white,
//                 child: new GestureDetector(
//                   onPanUpdate: (DragUpdateDetails details) {
//                     setState(() {
//                       RenderBox object = context.findRenderObject();
//                       Offset localPosition =
//                           object.globalToLocal(details.globalPosition);
//                       points = new List.from(points);
//                       points.add(localPosition);
//                     });
//                   },
//                   onPanEnd: (DragEndDetails details) => points.add(null),
//                   child: CustomPaint(
//                     painter: Painter(
//                         points: points,
//                         color: color,
//                         strokeCap: strokeCap,
//                         strokeWidth: strokeWidth,
//                         painters: painterList),
//                     size: Size.infinite,
//                   ),
//                 ),
//               ),
//             )
//           : Center(child: CircularProgressIndicator()),
//       floatingActionButton:
//           Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//         Container(
//           height: 70.0,
//           width: 56.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//               parent: controller,
//               curve: Interval(0.0, 1.0 - 0 / 3 / 2.0, curve: Curves.easeOut),
//             ),
//             child: FloatingActionButton(
//               tooltip: "Clear",
//               mini: true,
//               child: Icon(Icons.clear),
//               onPressed: () {
//                 forClear = "!save";
//                 convertWidgetToImage();

//                 points.clear();
//                 painterList.clear();
//               },
//             ),
//           ),
//         ),
//         Container(
//           height: 70.0,
//           width: 56.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//               parent: controller,
//               curve: Interval(0.0, 1.0 - 1 / 3 / 2.0, curve: Curves.easeOut),
//             ),
//             child: FloatingActionButton(
//               tooltip: "Erase",
//               mini: true,
//               child: FaIcon(FontAwesomeIcons.eraser),
//               onPressed: () {
//                 Color temp;
//                 temp = Colors.white;
//                 if (temp != null) {
//                   setState(() {
//                     painterList.add(Painter(
//                         points: points.toList(),
//                         color: color,
//                         strokeCap: strokeCap,
//                         strokeWidth: strokeWidth));
//                     points.clear();
//                     strokeCap = StrokeCap.round;
//                     strokeWidth = 5.0;
//                     color = temp;
//                   });
//                 }
//               },
//             ),
//           ),
//         ),
//         Container(
//           height: 70.0,
//           width: 56.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//               parent: controller,
//               curve: Interval(0.0, 1.0 - 1 / 3 / 2.0, curve: Curves.easeOut),
//             ),
//             child: FloatingActionButton(
//               tooltip: "Draw",
//               mini: true,
//               child: Icon(Icons.brush),
//               onPressed: () {
//                 Color temp;
//                 temp = Colors.black;
//                 if (temp != null) {
//                   setState(() {
//                     painterList.add(Painter(
//                         points: points.toList(),
//                         color: color,
//                         strokeCap: strokeCap,
//                         strokeWidth: strokeWidth));
//                     points.clear();
//                     strokeCap = StrokeCap.round;
//                     strokeWidth = 5.0;
//                     color = temp;
//                   });
//                 }
//               },
//             ),
//           ),
//         ),
//         Container(
//             height: 70.0,
//             width: 56.0,
//             alignment: FractionalOffset.topCenter,
//             child: ScaleTransition(
//                 scale: CurvedAnimation(
//                   parent: controller,
//                   curve:
//                       Interval(0.0, 1.0 - 2 / 3 / 2.0, curve: Curves.easeOut),
//                 ),
//                 child: FloatingActionButton(
//                     tooltip: "Change Color",
//                     mini: true,
//                     child: Icon(
//                       Icons.color_lens,
//                     ),
//                     onPressed: () async {
//                       Color temp;
//                       temp = await showDialog(
//                           context: context,
//                           builder: (context) => ColorDialog());
//                       if (temp != null) {
//                         setState(() {
//                           painterList.add(Painter(
//                               points: points.toList(),
//                               color: color,
//                               strokeCap: strokeCap,
//                               strokeWidth: strokeWidth));
//                           points.clear();
//                           strokeCap = StrokeCap.round;
//                           strokeWidth = 5.0;
//                           color = temp;
//                         });
//                       }
//                     }))),
//         Container(
//             height: 70.0,
//             width: 56.0,
//             alignment: FractionalOffset.topCenter,
//             child: ScaleTransition(
//                 scale: CurvedAnimation(
//                   parent: controller,
//                   curve:
//                       Interval(0.0, 1.0 - 2 / 3 / 2.0, curve: Curves.easeOut),
//                 ),
//                 child: FloatingActionButton(
//                     tooltip: "Save",
//                     mini: true,
//                     child: Icon(
//                       Icons.save_alt,
//                     ),
//                     onPressed: () async {
//                       Color temp;
//                       temp = Colors.black;
//                       convertWidgetToImage();
//                     }))),
//         FloatingActionButton(
//           tooltip: "Open Drawer",
//           child: AnimatedBuilder(
//             animation: controller,
//             builder: (BuildContext context, Widget child) {
//               return Transform(
//                 transform: Matrix4.rotationZ(controller.value * 0.5 * 3.1415),
//                 alignment: FractionalOffset.center,
//                 child: Icon(Icons.brush),
//               );
//             },
//           ),
//           onPressed: () {
//             if (controller.isDismissed) {
//               controller.forward();
//             } else {
//               controller.reverse();
//             }
//           },
//         ),
//       ]),
//     );
//   }
// }

// class Painter extends CustomPainter {
//   List<Offset> points;
//   Color color;
//   StrokeCap strokeCap;
//   double strokeWidth;
//   List<Painter> painters;

//   Painter(
//       {this.points,
//       this.color,
//       this.strokeCap,
//       this.strokeWidth,
//       this.painters = const []});

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (Painter painter in painters) {
//       painter.paint(canvas, size);
//     }

//     Paint paint = new Paint()
//       ..color = color
//       ..strokeCap = strokeCap
//       ..strokeWidth = strokeWidth;
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(Painter oldDelegate) => oldDelegate.points != points;
// }

// import 'dart:convert';
// // import 'dart:html';
// import 'dart:io';
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_signature_pad/flutter_signature_pad.dart';
// import 'colorPalette.dart';
// import 'package:screenshot/screenshot.dart';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class DrawPage extends StatefulWidget {
//   @override
//   DrawPageState createState() => new DrawPageState();
// }

// class DrawPageState extends State<DrawPage> with TickerProviderStateMixin {
//   AnimationController controller;
//   List<Offset> points = <Offset>[];
//   Color color = Colors.black;
//   StrokeCap strokeCap = StrokeCap.round;
//   double strokeWidth = 5.0;
//   List<Painter> painterList = [];
//   final _sign = GlobalKey<SignatureState>();
//   ByteData _img = ByteData(0);
//   File _imageFile;
//   ScreenshotController screenshotController = ScreenshotController();
//   GlobalKey _repaintKey = GlobalKey();
//   void convertWidgetToImage() async {
//     RenderRepaintBoundary renderRepaintBoundary =
//         _repaintKey.currentContext.findRenderObject();
//     ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
//     ByteData bytedata =
//         await boxImage.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List iInt8List = bytedata.buffer.asUint8List();
//     print(iInt8List);
//   }

//   @override
//   void initState() {
//     super.initState();
//     controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: RepaintBoundary(
//         child: Container(
//           child: GestureDetector(
//             onPanUpdate: (DragUpdateDetails details) {
//               setState(() {
//                 RenderBox object = context.findRenderObject();
//                 Offset localPosition =
//                     object.globalToLocal(details.globalPosition);
//                 points = new List.from(points);
//                 points.add(localPosition);
//               });
//             },
//             onPanEnd: (DragEndDetails details) => points.add(null),
//             child: CustomPaint(
//               painter: Painter(
//                   points: points,
//                   color: color,
//                   strokeCap: strokeCap,
//                   strokeWidth: strokeWidth,
//                   painters: painterList),
//               size: Size.infinite,
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton:
//           Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//         // Clear icon
//         Container(
//           height: 70.0,
//           width: 56.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//               parent: controller,
//               curve: Interval(0.0, 1.0 - 0 / 3 / 2.0, curve: Curves.easeOut),
//             ),
//             child: FloatingActionButton(
//               mini: true,
//               child: Icon(Icons.clear),
//               onPressed: () {
//                 points.clear();
//                 painterList.clear();
//               },
//             ),
//           ),
//         ),
//         // Making thi as an undo button
//         Container(
//           height: 70.0,
//           width: 56.0,
//           alignment: FractionalOffset.topCenter,
//           child: ScaleTransition(
//             scale: CurvedAnimation(
//               parent: controller,
//               curve: Interval(0.0, 1.0 - 1 / 3 / 2.0, curve: Curves.easeOut),
//             ),
//             child: FloatingActionButton(
//               mini: true,
//               child: Icon(Icons.lens),
//               onPressed: () {
//                 // points.clear();
//                 if (points.length != 0) {
//                   points.clear();
//                 } else if (points.length <= 0 && painterList.length <= 0) {
//                 } else {
//                   print(painterList.length);
//                   painterList.removeAt(painterList.length - 1);
//                 }
//               },
//             ),
//           ),
//         ),
//         // adding another color option here
//         Container(
//             height: 70.0,
//             width: 56.0,
//             alignment: FractionalOffset.topCenter,
//             child: ScaleTransition(
//                 scale: CurvedAnimation(
//                   parent: controller,
//                   curve:
//                       Interval(0.0, 1.0 - 2 / 3 / 2.0, curve: Curves.easeOut),
//                 ),
//                 child: FloatingActionButton(
//                     mini: true,
//                     child: Icon(
//                       Icons.color_lens,
//                       // color: Colors.green,
//                     ),
//                     onPressed: () async {
//                       Color temp;
//                       temp = await showDialog(
//                           context: context,
//                           builder: (context) => ColorDialog());
//                       if (temp != null) {
//                         setState(() {
//                           painterList.add(Painter(
//                               points: points.toList(),
//                               color: color,
//                               strokeCap: strokeCap,
//                               strokeWidth: strokeWidth));
//                           points.clear();
//                           strokeCap = StrokeCap.round;
//                           strokeWidth = 5.0;
//                           color = temp;
//                         });
//                       }
//                     }))),
//         Container(
//             height: 70.0,
//             width: 56.0,
//             alignment: FractionalOffset.topCenter,
//             child: ScaleTransition(
//                 scale: CurvedAnimation(
//                   parent: controller,
//                   curve:
//                       Interval(0.0, 1.0 - 2 / 3 / 2.0, curve: Curves.easeOut),
//                 ),
//                 child: FloatingActionButton(
//                     mini: true,
//                     child: Icon(
//                       Icons.color_lens,
//                       color: Colors.black,
//                     ),
//                     onPressed: () async {
//                       Color temp;
//                       temp = Colors.black;
//                       convertWidgetToImage();
//                       // final sign = _sign.currentState;
//                       // //retrieve image data, do whatever you want with it (send to server, save locally...)
//                       // final image = await sign.getData();
//                       // var ui;
//                       // var data = await image.toByteData(
//                       //     format: ui.ImageByteFormat.png);
//                       // sign.clear();
//                       // final encoded = base64.encode(data.buffer.asUint8List());
//                       // setState(() {
//                       //   _img = data;
//                       // });
//                       // debugPrint("onPressed " + encoded);

//                       // _imageFile = null;
//                       // screenshotController.capture().then((File image) async {
//                       //   //print("Capture Done");
//                       //   setState(() {
//                       //     _imageFile = image;
//                       //   });
//                       //   print(_imageFile);
//                       //   final bytes = File(_imageFile.path).readAsBytesSync();

//                       //   String img64 = base64Encode(bytes);
//                       //   print(img64);
//                       //   // var data = await image.toByteData(format: ui.ImageByteFormat.png);
//                       //   // // sign.clear();
//                       //   // final encoded = base64.encode(data.buffer.asUint8List());
//                       //   // final result =
//                       //   //     await ImageGallerySaver.save(image.readAsBytesSync()); // Save image to gallery,  Needs plugin  https://pub.dev/packages/image_gallery_saver
//                       //   print("File Saved to Gallery");
//                       // }).catchError((onError) {
//                       //   print(onError);
//                       // });

//                       //  await showDialog(
//                       //     context: context,
//                       //     builder: (context) => ColorDialog());
//                     }))),
//         FloatingActionButton(
//           child: AnimatedBuilder(
//             animation: controller,
//             builder: (BuildContext context, Widget child) {
//               return Transform(
//                 transform: Matrix4.rotationZ(controller.value * 0.5 * 3.1415),
//                 alignment: FractionalOffset.center,
//                 child: Icon(Icons.brush),
//               );
//             },
//           ),
//           onPressed: () {
//             if (controller.isDismissed) {
//               controller.forward();
//             } else {
//               controller.reverse();
//             }
//           },
//         ),
//       ]),
//     );
//   }
// }

// class Painter extends CustomPainter {
//   List<Offset> points;
//   Color color;
//   StrokeCap strokeCap;
//   double strokeWidth;
//   List<Painter> painters;

//   Painter(
//       {this.points,
//       this.color,
//       this.strokeCap,
//       this.strokeWidth,
//       this.painters = const []});

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (Painter painter in painters) {
//       painter.paint(canvas, size);
//     }

//     Paint paint = new Paint()
//       ..color = color
//       ..strokeCap = strokeCap
//       ..strokeWidth = strokeWidth;
//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(Painter oldDelegate) => oldDelegate.points != points;
// }
