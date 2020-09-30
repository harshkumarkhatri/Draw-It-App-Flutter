// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ForAddingToDB extends StatefulWidget {
//   @override
//   _ForAddingToDBState createState() => _ForAddingToDBState();
// }

// class _ForAddingToDBState extends State<ForAddingToDB> {
//   final DBref = FirebaseDatabase.instance.reference();
//   List countStor = [];
//   int count = 0;
//   SharedPreferences prefs;
//   var random;
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final fb = FirebaseDatabase.instance;

//   var uid;
//   void initState() {
//     super.initState();
//     init();
//   }

//   void init() async {
//     prefs = await SharedPreferences.getInstance();
//     uid = prefs.getString('uid');
//     print("Uid is $uid");
//     // readData();
//     // getData().then((val) {
//     //   print("This is val ${val.uid}");
//     // });
//     // print("snapshot is ${dbss.toString()}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ref = fb.reference();
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             child: Center(
//               child: RaisedButton(
//                 onPressed: () {
//                   setState(() {
//                     count++;
//                     countStor.add(count);
//                     countStor.add(
//                       "https://google.com",
//                       // prefs.getString('email'),
//                     );
//                   });
//                   writeData();
//                 },
//                 child: Text("Setting data"),
//               ),
//             ),
//           ),
//           Container(
//             child: Center(
//               child: RaisedButton(
//                 child: Text("Getting data"),
//                 onPressed: () {
//                   ref.child(uid).once().then((DataSnapshot snap) {
//                     print(snap);

//                     // This is the condition which will be check while we will be logging in again
//                     // We will be seeing of the snapshot value is null, If  yes then make a new one
//                     // Else do nothing as the snapshot already exists and we can use it directly
//                     print(snap.value);

//                     print(snap.key);
//                   });
//                   setState(() {
//                     // count++;
//                     // countStor.add(count);
//                     // countStor.add(
//                     //   "https://google.com",
//                     // prefs.getString('email'),
//                     // );
//                   });
//                   // writeData();
//                 },
//               ),
//             ),
//           ),
//           Container(
//             child: Center(
//               child: RaisedButton(
//                 child: Text("Checking snapshot"),
//                 onPressed: () {
//                   checkSnap();
//                   // ref.child(uid).once().then((DataSnapshot snap) {
//                   //   print(snap);
//                   //   print(snap.value["dataExist"]);
//                   //   print(snap.key);
//                   // });
//                   setState(() {
//                     // count++;
//                     // countStor.add(count);
//                     // countStor.add(
//                     //   "https://google.com",
//                     // prefs.getString('email'),
//                     // );
//                   });
//                   // writeData();
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future readData() {
//     DBref.once().then((DataSnapshot dataSnapshot) {
//       setState(() {
//         dbss = dataSnapshot;
//       });
//     });
//   }

//   checkSnap() async {
//     final User user = await auth.currentUser;
//     print(user);
//     print(await FirebaseDatabase.instance
//         .reference()
//         .child('user')
//         .equalTo(user.uid));
//   }

//   getData() async {
//     final User user = await auth.currentUser;
//     return await FirebaseDatabase.instance
//         .reference()
//         .child('user')
//         .equalTo(user.uid);
//     // print(user);
//     // print(random);
//     // random = user.uid;
//     // print(random);
//   }

//   DataSnapshot dbss;

//   void writeData() async {
//     DBref.child(uid).set({
//       'fname': "harsh",
//       'lname': "_lnam",
//       'email': "widget",
//       'dataExist': countStor.toString(),
//       'dp': "imageUrl"
//     });
//     print("Data written");
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForAddingToDB extends StatefulWidget {
  @override
  _ForAddingToDBState createState() => _ForAddingToDBState();
}

class _ForAddingToDBState extends State<ForAddingToDB> {
  final DBref = FirebaseDatabase.instance.reference();
  List countStor = [];
  int count = 0;
  SharedPreferences prefs;
  var random;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // FirebaseFirestore secondaryApp = Firebase.app("DrawIt");
  // FirebaseApp secondaryApp = Firebase.app('DrawIt');
// FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: secondaryApp);

  var uid;
  void initState() {
    super.initState();
    Firebase.initializeApp();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    print("Uid is $uid");
    // readData();
    // getData().then((val) {
    //   print("This is val ${val.uid}");
    // });
    // print("snapshot is ${dbss.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();

    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('details');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': "Harsh Kumar Khatri", // John Doe
            'company': "CPU", // Stokes and Sons
            'age': 42 // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      print("added");
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    count++;
                    countStor.add(count);
                    countStor.add(
                      "https://google.com",
                      // prefs.getString('email'),
                    );
                  });
                  addUser();
                  // writeData();
                },
                child: Text("Firestore adding data"),
              ),
            ),
          ),
          Container(
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    count++;
                    countStor.add(count);
                    countStor.add(
                      "https://google.com",
                      // prefs.getString('email'),
                    );
                  });
                  // addUser();
                  // writeData();
                },
                child: Text("Setting data"),
              ),
            ),
          ),
          Container(
            child: Center(
              child: RaisedButton(
                child: Text("Getting data"),
                onPressed: () {
                  ref.child(uid).once().then((DataSnapshot snap) {
                    print(snap);

                    // This is the condition which will be check while we will be logging in again
                    // We will be seeing of the snapshot value is null, If  yes then make a new one
                    // Else do nothing as the snapshot already exists and we can use it directly
                    print(snap.value);

                    print(snap.key);
                  });
                  setState(() {
                    // count++;
                    // countStor.add(count);
                    // countStor.add(
                    //   "https://google.com",
                    // prefs.getString('email'),
                    // );
                  });
                  // writeData();
                },
              ),
            ),
          ),
          Container(
            child: Center(
              child: RaisedButton(
                child: Text("Checking snapshot"),
                onPressed: () {
                  checkSnap();
                  // ref.child(uid).once().then((DataSnapshot snap) {
                  //   print(snap);
                  //   print(snap.value["dataExist"]);
                  //   print(snap.key);
                  // });
                  setState(() {
                    // count++;
                    // countStor.add(count);
                    // countStor.add(
                    //   "https://google.com",
                    // prefs.getString('email'),
                    // );
                  });
                  // writeData();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future readData() {
    DBref.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        dbss = dataSnapshot;
      });
    });
  }

  checkSnap() async {
    final User user = await auth.currentUser;
    print(user);
    print(await FirebaseDatabase.instance
        .reference()
        .child('user')
        .equalTo(user.uid));
  }

  getData() async {
    final User user = await auth.currentUser;
    return await FirebaseDatabase.instance
        .reference()
        .child('user')
        .equalTo(user.uid);
    // print(user);
    // print(random);
    // random = user.uid;
    // print(random);
  }

  DataSnapshot dbss;

  void writeData() async {
    DBref.child(uid).set({
      'fname': "harsh",
      'lname': "_lnam",
      'email': "widget",
      'dataExist': countStor.toString(),
      'dp': "imageUrl"
    });
    print("Data written");
  }
}
