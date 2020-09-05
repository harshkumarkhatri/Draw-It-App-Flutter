// // This is working, color palette, top 3 dots, undo feature, clear screen feature
// import 'package:flutter/material.dart';
// // import 'dart:math';
// import 'colorPalette.dart';

// void main() {
//   runApp(MaterialApp(home: DrawPage()));
// }

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

//   @override
//   void initState() {
//     super.initState();
//     controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   void choiceAction(choice) {
//     if (choice == 'Logout') {
//       print("Logout");
//     } else if (choice == 'Settings') {
//       print("Settings");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Draw It"),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: choiceAction,
//             itemBuilder: (BuildContext context) {
//               return {'Logout', 'Settings'}.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         child: GestureDetector(
//           onPanUpdate: (DragUpdateDetails details) {
//             setState(() {
//               RenderBox object = context.findRenderObject();
//               Offset localPosition =
//                   object.globalToLocal(details.globalPosition);
//               points = new List.from(points);
//               points.add(localPosition);
//               print(points);
//             });
//           },
//           onPanEnd: (DragEndDetails details) => points.add(null),
//           child: CustomPaint(
//             painter: Painter(
//                 points: points,
//                 color: color,
//                 strokeCap: strokeCap,
//                 strokeWidth: strokeWidth,
//                 painters: painterList),
//             size: Size.infinite,
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



























// This is not working yet. I was trying to create another array which will be holding the points.
// import 'package:flutter/material.dart';
// // import 'dart:math';
// import 'colorPalette.dart';

// void main() {
//   runApp(MaterialApp(home: DrawPage()));
// }

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
//   List<List> forUndo = [];

//   @override
//   void initState() {
//     super.initState();
//     controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   void choiceAction(choice) {
//     if (choice == 'Logout') {
//       print("Logout");
//     } else if (choice == 'Settings') {
//       print("Settings");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Draw It"),
//         actions: [
//           PopupMenuButton<String>(
//             onSelected: choiceAction,
//             itemBuilder: (BuildContext context) {
//               return {'Logout', 'Settings'}.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         child: GestureDetector(
//           onPanUpdate: (DragUpdateDetails details) {
//             setState(() {
//               RenderBox object = context.findRenderObject();
//               // points.clear();
//               Offset localPosition =
//                   object.globalToLocal(details.globalPosition);
//               Object _localPosition = localPosition;
//               points = new List.from(points);
//               points.add(localPosition);
//               print(points);
//               // painterList.add(_localPosition);
//             });
//           },
//           onPanEnd: (DragEndDetails details) {
//             forUndo.add(points);
//             points.add(null);
//           },
//           child: CustomPaint(
//             painter: Painter(
//                 points: points,
//                 color: color,
//                 strokeCap: strokeCap,
//                 strokeWidth: strokeWidth,
//                 painters: painterList),
//             size: Size.infinite,
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
//                 // if (points.length != 0) {
//                 //   points.clear();
//                 // } else if (points.length <= 0 && painterList.length <= 0) {
//                 // } else {
//                 //   print(painterList.length);
//                 //   painterList.removeAt(painterList.length - 1);
//                 // }
//                 print(forUndo.length);
//                 // List demo=forUndo.removeLast();
// // print(points.runtimeType);
//                 if (forUndo[forUndo.length - 1] == points) {
//                   print("they are equal");
//                   print(points.remove(forUndo[forUndo.length - 1]));
//                 }
//                 // forUndo.
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