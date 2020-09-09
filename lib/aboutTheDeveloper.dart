import 'package:flutter/material.dart';
import 'del_variables.dart' as xyz;

class AboutTheDev extends StatefulWidget {
  @override
  _AboutTheDevState createState() => _AboutTheDevState();
}

class _AboutTheDevState extends State<AboutTheDev> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About the developer"),
      ),
      body: Center(
        child: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              isSwitched ? xyz.savLoc = "Cloud" : xyz.savLoc = "Memory";
              print(isSwitched);
              print(xyz.savLoc);
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ),
    );
  }
}
