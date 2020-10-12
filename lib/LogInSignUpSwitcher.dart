// This page has the code related to the login signup switcher screen

import 'package:draw_it_app/LoginPage.dart';
import 'package:draw_it_app/SignUpPage.dart';
import 'package:flutter/material.dart';

class LogInSignUpSwitcher extends StatefulWidget {
  @override
  _LogInSignUpSwitcherState createState() => _LogInSignUpSwitcherState();
}

class _LogInSignUpSwitcherState extends State<LogInSignUpSwitcher>
    with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(125),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: 82,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/appLogo.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
                controller: controller,
                indicatorWeight: 4,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Tab(
                    child: Text("Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  )
                ]),
          ),
        ),
        body: TabBarView(
          children: [LoginPage(), SignUp()],
          controller: controller,
        ));
  }
}
