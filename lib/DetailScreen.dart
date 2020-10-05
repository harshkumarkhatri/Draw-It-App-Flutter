// This file has the widget/Screen which will be displayed when we click on any of the image from the gridview.
// It shows us an enlarged image of the one we have tapped on.

import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

import 'ImagesGridview.dart';

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

// Setting values to variables.
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

// Deleting the image from Firebase Storage.
  Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
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
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ImagesGridView()));
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

// For Sharing the Image.
  void shareFile(imageLink) async {
    var request = await HttpClient().getUrl(Uri.parse(imageLink));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Share This Image', 'amlog.jpg', bytes, 'image/jpg',
        // Message which will be there when we share an image.
        text:
            "Hey, I have made this image using Draw It app. You can also make yours.");
  }
}
