// This file has the code related to about the developer screen.

import 'package:flutter/material.dart';

class AboutTheApp extends StatefulWidget {
  @override
  _AboutTheAppState createState() => _AboutTheAppState();
}

class _AboutTheAppState extends State<AboutTheApp> {
  double _animatedHeight = 100.0;
  bool initial1 = false;
  bool initial2 = false;
  bool initial3 = false;
  bool initial4 = false;
  bool initial5 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About the App"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 28, right: 28),
            child: Column(
              children: [
                SizedBox(height: 40),
                Center(
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/appLogo.png",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                  child: Text(
                    "This is an app which i have build as my technovation project for 5th semester. With this app use can think and lay their imagination out on our canvas and can save to their gallery or to out cloud.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () => setState(() {
                          _animatedHeight == 0.0
                              ? _animatedHeight = 100.0
                              : _animatedHeight = 00.0;
                          initial1 == false
                              ? initial1 = true
                              : initial1 = false;
                        }),
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("What is Draw It?",
                                    style: TextStyle(fontSize: 18)),
                                Icon(Icons.arrow_circle_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                      initial1 == true
                          ? new AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    "It is an app with the help of which you can pen down your thoughts on our canvas and can save them to wither your devie or to online storage and have a look at them later.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.6,
                                        height: 1.1)),
                              ),
                              color: Colors.tealAccent,
                            )
                          : Container(height: 0, width: 0)
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () => setState(() {
                          _animatedHeight == 0.0
                              ? _animatedHeight = 100.0
                              : _animatedHeight = 00.0;
                          initial2 == false
                              ? initial2 = true
                              : initial2 = false;
                        }),
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 250,
                                  child: Text(
                                      "Which language is used to make this app?",
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18)),
                                ),
                                Icon(Icons.arrow_circle_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                      initial2 == true
                          ? new AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    "This app has been made in Flutter and we are using Firebase storage to save images online.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.6,
                                        height: 1.1)),
                              ),
                              color: Colors.tealAccent,
                            )
                          : Container(height: 0, width: 0)
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () => setState(() {
                          _animatedHeight == 0.0
                              ? _animatedHeight = 100.0
                              : _animatedHeight = 00.0;
                          initial3 == false
                              ? initial3 = true
                              : initial3 = false;
                        }),
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 250,
                                  child: Text(
                                      "My screen is not clearing after i press the clear button. What should i do?",
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18)),
                                ),
                                Icon(Icons.arrow_circle_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                      initial3 == true
                          ? new AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    "You can start drawing as if the screen is blank and as soon as you will start drawing the screen will turn blank again.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.6,
                                        height: 1.1)),
                              ),
                              color: Colors.tealAccent,
                            )
                          : Container(height: 0, width: 0)
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () => setState(() {
                          _animatedHeight == 0.0
                              ? _animatedHeight = 100.0
                              : _animatedHeight = 00.0;
                          initial4 == false
                              ? initial4 = true
                              : initial4 = false;
                        }),
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(
                                        "After i click on save button when the save to storage is enabled, the screen doen not turns blank. What should i do?",
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Icon(Icons.arrow_circle_down)
                                ],
                              )),
                        ),
                      ),
                      initial4 == true
                          ? new AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    "You should start working on your new art and as soon as you will start drawing the screen will clear as if there was nothing prior to this on the screen.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.6,
                                        height: 1.1)),
                              ),
                              color: Colors.tealAccent,
                            )
                          : Container(height: 0, width: 0)
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () => setState(() {
                          _animatedHeight == 0.0
                              ? _animatedHeight = 100.0
                              : _animatedHeight = 00.0;
                          initial5 == false
                              ? initial5 = true
                              : initial5 = false;
                        }),
                        child: new Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 250,
                                    child: Text(
                                        "What all things can i do in this app?",
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Icon(Icons.arrow_circle_down)
                                ],
                              )),
                        ),
                      ),
                      initial5 == true
                          ? new AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    "You can drow what ever comes to your mind, wou can make notes of particular things while you are studying and get the feel as if you are writing on paper, you can also create signatures with this and save them to an image and then use them on pages as your digital signature as if they are done by you.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.6,
                                        height: 1.1)),
                              ),
                              color: Colors.tealAccent,
                            )
                          : Container(height: 0, width: 0)
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(child: Text("Version:1.0.2")),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
