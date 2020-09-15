import 'package:draw_it_app/LoginPage.dart';
import 'package:draw_it_app/SignUpPage.dart';
import 'package:flutter/material.dart';

class LogInSignUpSwitcher extends StatefulWidget {
  @override
  _LogInSignUpSwitcherState createState() => _LogInSignUpSwitcherState();
}

class _LogInSignUpSwitcherState extends State<LogInSignUpSwitcher> with SingleTickerProviderStateMixin{
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
          preferredSize: Size.fromHeight(150),
          child: SafeArea(
            child: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 82,
                    image: NetworkImage(
                        "https://cdn.dribbble.com/users/1107687/avatars/normal/ddaa5340d270b8f4b073273aafbd34e2.png?1536764943"),
                  ),
                ],
              ),
              bottom: TabBar(
                  controller: controller,
                  indicatorWeight: 4,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(
                      // icon: Icon(Icons.lock),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Tab(
                      // icon: Icon(Icons.account_circle),
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    )
                  ]),
            ),
          ),
        ),
        body: TabBarView(
          children: [LoginPage(),SignUp()],
          controller: controller,
        ));
  }
}