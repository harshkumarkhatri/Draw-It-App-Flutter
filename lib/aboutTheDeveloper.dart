import 'package:draw_it_app/aboutTheApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'webBrowserOpen.dart';

class AboutTheDev extends StatefulWidget {
  @override
  _AboutTheDevState createState() => _AboutTheDevState();
}

class _AboutTheDevState extends State<AboutTheDev> {
  bool isSwitched = false;
  bool _saveTo;
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    _saveTo = prefs.getBool('_saveTo') ?? false;
    setState(() {
      _saveTo;
    });
    print(prefs.getBool('_saveTo'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About the Developer"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent,
                      image: DecorationImage(
                        image: AssetImage(
                          // TODO:add the asset image of me
                          "assets/myImage.jpg",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Harsh Kumar Khatri",
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 30, right: 30),
                  child: Text(
                    "I ama a CSE Undergraduate from Career Point University. I love to learn about technology and explore various different dynamics of it. This is a for my technovation project for 5th semester.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AboutTheApp(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      "ABOUT THE APP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[200],
                          Colors.blue[700],
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text("Follow me:"),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        openWebBroser("https://twitter.com/harshkhatri24");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.twitter,
                        size: 30,
                        color: Color.fromRGBO(40, 168, 237, 1),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          openWebBroser("https://github.com/harshkumarkhatri");
                        },
                        child: FaIcon(FontAwesomeIcons.github, size: 30)),
                    GestureDetector(
                      onTap: () {
                        openWebBroser(
                            "https://www.youtube.com/channel/UCKNtMU9M559bmXxKoT6YeJw");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.youtube,
                        size: 30,
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        openWebBroser(
                            "https://www.linkedin.com/in/harshkumarkhatri/");
                      },
                      child: FaIcon(
                        FontAwesomeIcons.linkedinIn,
                        size: 30,
                        color: Color.fromRGBO(14, 118, 168, 1),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
