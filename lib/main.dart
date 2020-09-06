// Try 2
import 'package:draw_it_app/del_screenshot_test.dart';
import 'package:draw_it_app/draw2.dart';
import 'package:draw_it_app/flutter_sig_pad_test_1.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'draw.dart';

void main() {
  runApp(MaterialApp(home: ScreenShotCapture()));
}

// Try 1
// import 'package:flutter/material.dart';

// // import 'graphic';
// void main() {
//   runApp(MaterialApp(home: HomePage()));
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool del = false;
//   Color chosenColor = Colors.black;
//   List<Offset> _points = <Offset>[];
//   List<Painterr> painterList = [];
//   AnimationController controller;
//   List<Offset> points = <Offset>[];
//   Color color = Colors.black;
//   StrokeCap strokeCap = StrokeCap.round;
//   double strokeWidth = 5.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: GestureDetector(
//         onPanUpdate: (DragUpdateDetails details) {
//           setState(() {
//             RenderBox object = context.findRenderObject();
//             Offset _localPosition =
//                 object.globalToLocal(details.globalPosition);
//             _points = List.from(_points)..add(_localPosition);
//           });
//         },
//         onPanEnd: (DragEndDetails details) => _points.add(null),
//         child: CustomPaint(
//             painter:
//                 // Signature(points: _points, chosenColor: chosenColor, del: del),
//                 // Signature(
//                 //     points: points,
//                 //     color: color,
//                 //     strokeCap: strokeCap,
//                 //     strokeWidth: strokeWidth,
//                 //     painters: painterList),
//                 Painterr(
//                     points: points,
//                     color: color,
//                     strokeCap: strokeCap,
//                     strokeWidth: strokeWidth,
//                     painters: painterList),
//             // size: Size.infinite,

//             size: Size.infinite),
//       )),
//       floatingActionButton: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   Color temp;
//                   temp = Colors.red;
//                   if (temp != null) {
//                     setState(() {
//                       painterList.add(Painterr(
//                           points: points.toList(),
//                           color: color,
//                           strokeCap: strokeCap,
//                           strokeWidth: strokeWidth));
//                       points.clear();
//                       strokeCap = StrokeCap.round;
//                       strokeWidth = 5.0;
//                       color = temp;
//                     });
//                   }
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     chosenColor = Colors.white;
//                     // del=true;
//                     del == false ? del = true : del = false;
//                   });
//                 },
//                 child: Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.orange,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               FloatingActionButton(
//                 onPressed: () {
//                   _points.clear();
//                 },
//                 child: Icon(Icons.clear),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class Signature extends CustomPainter{

// //   List<Offset> points;

// //   Signature({this.points})

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //   Paint paint=new Paint()
// //   ..color=Colors.black
// //   ..strokeCap=StrokeCap.round
// //   ..strokeWidth=5.0;

// //     for (int i=0;i<points.length-1;i++){
// //       if(points[i]!=null && points[i+1]!=null){
// //         canvas.drawLine(points[i], points[i+1], paint);
// //       }
// //     }
// //     }

// //     @override
// //     bool shouldRepaint(Signature oldDelegate)=>oldDelegate.points!=points;

// // }

// class Painterr extends CustomPainter {
//   List<Offset> points;
//   Color color;
//   StrokeCap strokeCap;
//   double strokeWidth;
//   List<Painterr> painters;

//   Painterr(
//       {this.points,
//       this.color,
//       this.strokeCap,
//       this.strokeWidth,
//       this.painters = const []});

//   @override
//   void paint(Canvas canvas, Size size) {
//     // for (Painterr painter in painters) {
//     //   painter.paint(canvas, size);
//     // }

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
//   bool shouldRepaint(Painterr oldDelegate) => oldDelegate.points != points;
// }

// Original working solution
// class Signature extends CustomPainter {
//   List<Offset> points;
//   Color chosenColor;
//   bool del;

//   Signature({this.points, this.chosenColor, this.del});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = chosenColor
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 10.0;
//     // Paint erase = new Paint()
//     //   ..color = Colors.white
//     //   ..strokeCap = StrokeCap.round
//     //   ..strokeWidth = 10.0;
//     print("del is " + del.toString());

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null && del == false) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//       // else if (points[i] != null && points[i + 1] != null && del == true) {
//       //   // canvas.drawLine(points[i], points[i + 1], erase);
//       //   canvas.drawColor(Colors.transparent, Mode.CLEAR)
//       // }
//     }
//     // canvas.restore();
//   }

//   @override
//   bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
// }

// import 'package:flutter/material.dart';
// // import 'graphic';
// void main() {
//   runApp(MaterialApp(home: HomePage()));
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool del = false;
//   Color chosenColor = Colors.black;
//   List<Offset> _points = <Offset>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: GestureDetector(
//         onPanUpdate: (DragUpdateDetails details) {
//           setState(() {
//             RenderBox object = context.findRenderObject();
//             Offset _localPosition =
//                 object.globalToLocal(details.globalPosition);
//             _points = List.from(_points)..add(_localPosition);
//           });
//         },
//         onPanEnd: (DragEndDetails details) => _points.add(null),
//         child: CustomPaint(
//             painter:
//                 Signature(points: _points, chosenColor: chosenColor, del: del),
//             size: Size.infinite),
//       )),
//       floatingActionButton: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     chosenColor = Colors.red;
//                   });
//                 },
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     chosenColor = Colors.white;
//                     // del=true;
//                     del == false ? del = true : del = false;
//                   });
//                 },
//                 child: Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.orange,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               FloatingActionButton(
//                 onPressed: () {
//                   _points.clear();
//                 },
//                 child: Icon(Icons.clear),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class Signature extends CustomPainter{

// //   List<Offset> points;

// //   Signature({this.points})

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //   Paint paint=new Paint()
// //   ..color=Colors.black
// //   ..strokeCap=StrokeCap.round
// //   ..strokeWidth=5.0;

// //     for (int i=0;i<points.length-1;i++){
// //       if(points[i]!=null && points[i+1]!=null){
// //         canvas.drawLine(points[i], points[i+1], paint);
// //       }
// //     }
// //     }

// //     @override
// //     bool shouldRepaint(Signature oldDelegate)=>oldDelegate.points!=points;

// // }

// class Signature extends CustomPainter {
//   List<Offset> points;
//   Color chosenColor;
//   bool del;

//   Signature({this.points, this.chosenColor, this.del});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = chosenColor
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 10.0;
//     // Paint erase = new Paint()
//     //   ..color = Colors.white
//     //   ..strokeCap = StrokeCap.round
//     //   ..strokeWidth = 10.0;
//     print("del is " + del.toString());

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null && del == false) {
//         canvas.drawLine(points[i], points[i + 1], paint);
//       }
//       // else if (points[i] != null && points[i + 1] != null && del == true) {
//       //   // canvas.drawLine(points[i], points[i + 1], erase);
//       //   canvas.drawColor(Colors.transparent, Mode.CLEAR)
//       // }
//     }
//     // canvas.restore();
//   }

//   @override
//   bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
// }
