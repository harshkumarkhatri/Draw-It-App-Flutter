import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'del_variables.dart' as xyz;

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
          title: Text("About the developer"),
        ),
        body: Padding(
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
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Some text about me",
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text("Some description about me")
            ],
          ),
        )
        // Center(
        //   child: Switch(
        //     value: _saveTo,
        //     onChanged: (value) {
        //       setState(() {
        //         _saveTo = value;
        //         // _saveTo ? _saveTo = true : _saveTo = false;
        //         isSwitched = _saveTo;
        //         print(isSwitched);
        //         print(_saveTo);

        //       });
        //     },
        //     activeTrackColor: Colors.lightGreenAccent,
        //     activeColor: Colors.green,
        //     // value: isSwitched,
        //     // onChanged: (value) {
        //     //   setState(() {
        //     //     isSwitched = value;
        //     //     isSwitched ? xyz.savLoc = "Cloud" : xyz.savLoc = "Memory";
        //     //     print(isSwitched);
        //     //     print(xyz.savLoc);
        //     //   });
        //     // },
        //     // activeTrackColor: Colors.lightGreenAccent,
        //     // activeColor: Colors.green,
        //   ),
        // ),
        );
  }
}
