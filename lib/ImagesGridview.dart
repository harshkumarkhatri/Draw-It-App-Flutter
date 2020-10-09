// This file displays the images which are stored in the Firebase Storage and have their links stored in Firestore.
// The images are displayd in form of GridView.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ext_storage/ext_storage.dart';
import 'DetailScreen.dart';

class ImagesGridView extends StatefulWidget {
  @override
  _ImagesGridViewState createState() => _ImagesGridViewState();
}

class _ImagesGridViewState extends State<ImagesGridView> {
  final DBref = FirebaseDatabase.instance.reference();
  List countStor = [];
  int count = 0;
  SharedPreferences prefs;
  var random;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fb = FirebaseDatabase.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool itemsSwitcher = false;

  // Dynamic list o store the links
  List<dynamic> li = [];

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
    var firebaseUser = auth.currentUser;
    firestoreInstance
        .collection("ImageLinks")
        .document(firebaseUser.uid)
        .get()
        .then((value) {
      setState(() {
        li = value.data()['links'];
        if (li[0] == null) {
          li.removeAt(0);
        }
        if (li.length < 1) {
          itemsSwitcher = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Images"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Text(
                    "Images Saved to Local Storage can be found in Gallery",
                  ),
                ),
              ),
            ),
            itemsSwitcher == true
                ? Center(
                    child: Container(
                        child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "You don't have any images saved to cloud. Start saving and we will display them here"),
                  )))
                : Expanded(
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: item,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList()))
          ],
        ),
      ),
    );
  }
}
