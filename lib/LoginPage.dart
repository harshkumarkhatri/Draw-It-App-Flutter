// This file has the code related to Login page.

import 'package:draw_it_app/initialScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email text field
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: TextFormField(
                controller: nameHolder,
                validator: (input) {
                  if (input.isEmpty) {
                    return "Please type a mail";
                  }
                },
                onSaved: (input) {
                  _email = input;
                },
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),

            // Password text field
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: nameHolder2,
                obscureText: true,
                validator: (input) {
                  if (input.length < 2) {
                    return "Password is small";
                  }
                },
                onSaved: (input) {
                  _password = input;
                },
                decoration: InputDecoration(labelText: "Password"),
              ),
            ),

            // Submit button
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  signin();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Sign In"),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Circular progress bar to show the time taken while login
            SizedBox(height: 15),
            loading == true && _email != null && _password.length > 2
                ? CircularProgressIndicator()
                : Container(),
            SizedBox(height: 15),

            // Skip for now button
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: RaisedButton(
                onPressed: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => SplashScreen()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Skip for Now"),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();

  // Clearing the textfields after successful/un-successful signin
  clearTextInput() {
    nameHolder.clear();
    nameHolder2.clear();
  }

  // SignIning in with email and password
  Future<void> signin() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final formState = _formKey.currentState;

    // When we have a valid form state
    if (formState.validate()) {
      formState.save();

      // Trying to sign user in
      try {
        UserCredential result = (await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', result.user.email);
        prefs.setString('uid', result.user.uid);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SplashScreen()));
      }

      // Catching exception/error and displaying a message in the snackbar
      catch (e) {
        Fluttertoast.showToast(
            msg:
                "No account exist with these credentials.\nPlease check your credentials and try logging in again.");
        setState(() {
          loading = false;
        });
        clearTextInput();
      }
    }
  }
}
