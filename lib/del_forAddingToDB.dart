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

import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

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

  // Dynamic list o store the links
  List<dynamic> li = [];
  // FirebaseFirestore secondaryApp = Firebase.app("DrawIt");
  // FirebaseApp secondaryApp = Firebase.app('DrawIt');
// FirebaseFirestore firestore = FirebaseFirestore.instanceFor(app: secondaryApp);

  var uid;
  void initState() {
    super.initState();
    Firebase.initializeApp();
    init();
  }

  final firestoreInstance = Firestore.instance;

  void init() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    print("Uid is $uid");
    var firebaseUser = auth.currentUser;
    firestoreInstance
        .collection("ImageLinks")
        .document(firebaseUser.uid)
        .get()
        .then((value) {
      print(value.data()['links'].runtimeType);
      print("Length is ${value.data()['links'].length}");
      setState(() {
        li = value.data()['links'];
        if (li[0] == null) {
          li.removeAt(0);
        }
      });

      for (int i = 0; i < li.length; i++) {
        print("link is ${li[i]}");
      }
    });
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
          // TODO: To be deleted
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
          // TODO: To be deleted
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
          // TODO: To be deleted
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
          // TODO: To be deleted
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
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: li.length,
          //       itemBuilder: (BuildContext ctxt, int Index) {
          //         return new
          //             Image(image: NetworkImage(li[Index].toString()));
          //             // Text(li[Index].toString(),
          //             //     style: TextStyle(color: Colors.red));
          //       }),
          // )
          Expanded(
              child: GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height,
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(
                    5,
                  ),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: li
                      .map((item) => GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return DetailScreen(item);
                              }));
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.cover),
                                  ),
                                  // child: Transform.translate(
                                  //   offset: Offset(55, -50),
                                  //   child: Container(
                                  //     margin: EdgeInsets.symmetric(
                                  //         horizontal: 65, vertical: 65),
                                  //     decoration: BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(10),
                                  //         color: Colors.white),
                                  //     child: Icon(Icons.bookmark_border,size: 15,),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ))
                      .toList()))
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

// Testing:- Zooming an image onTap
class DetailScreen extends StatefulWidget {
  DetailScreen(this.item);
  final String item;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool switcher = true;
  CollectionReference users =
      FirebaseFirestore.instance.collection("ImageLinks");

  List<dynamic> li;
  final firestoreInstance = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences prefs;
  var uid;
  String filePath;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    var firebaseUser = auth.currentUser;
    firestoreInstance
        .collection("ImageLinks")
        .document(firebaseUser.uid)
        .get()
        .then((value) {
      print("Run time type is  ${value.data()['links'].runtimeType}");
      filePath = widget.item
          .replaceAll(
              new RegExp(
                  r'https://firebasestorage.googleapis.com/v0/b/dial-in-21c50.appspot.com/o/default_images%2F'),
              '')
          .split('?')[0];

      print("File path is ${filePath}");

      setState(() {
        li = value.data()['links'];
      });
    });
  }

  Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
    print("Successfully deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragStart: (DragStartDetails dd) {
                    print("Dragging");

                    setState(() {
                      switcher == true ? switcher = false : switcher = true;
                    });
                    print(switcher);
                  },
                  child: Center(
                    child: Hero(
                      tag: 'imageHero',
                      child: Image.network(
                        widget.item,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // Bottom buttons for delete and share
              switcher == true
                  ? Container()
                  : Container(
                      color: Colors.white,
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 6,
                            right: MediaQuery.of(context).size.width / 6),
                        child: Row(
                          children: [
                            // Delete
                            GestureDetector(
                              onTap: () {
                                print("Gesture detected");
                                li.remove(widget.item);
                                print("removed ${li}");
                                setState(() {
                                  users.document(uid).updateData(
                                    {"links": li},
                                  );
                                });
                                deleteImage(widget.item);
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.delete_outline_outlined,
                                    ),
                                    Text("Delete")
                                  ],
                                ),
                              ),
                            ),

                            // Share
                            GestureDetector(
                              onTap: () {
                                shareFile(widget.item);
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.share_outlined,
                                      ),
                                      Text("Share")
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),

          // Widgets on top left
          Positioned(
            top: 15,
            right: 15,
            child: Row(
              children: [
                // More widget
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    setState(() {
                      switcher == true ? switcher = false : switcher = true;
                    });
                    print(switcher);
                  },
                  child: SafeArea(
                    child: Container(
                      height: 30,
                      // width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[200],
                        borderRadius: BorderRadius.circular(
                          3,
                        ),
                      ),
                      child: Container(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          child: Text("More"),
                        )),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8),

                // Cross widget
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SafeArea(
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[200], shape: BoxShape.circle),
                      child: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void shareFile(imageLink) async {
    var request = await HttpClient().getUrl(Uri.parse(imageLink));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Share This Image', 'amlog.jpg', bytes, 'image/jpg',
        text:
            "Hey, I have made this image using Draw It app. You can also make yours.");
  }
}
