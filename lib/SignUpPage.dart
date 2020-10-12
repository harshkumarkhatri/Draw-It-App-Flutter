// This file has the code related to the signup page of the app.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'initialScreen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = "";
  String successMessage = "";
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  String _email, _password;
  final _passwordController = TextEditingController(text: '');
  bool loading = false;
  final DBref = FirebaseDatabase.instance.reference();
  SharedPreferences prefs;
  String pass;

// Initializing the firebase instance for firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users =
      FirebaseFirestore.instance.collection("ImageLinks");

  var uid, email;
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    email = prefs.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formstate,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Email
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

              // Password
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: nameHolder2,
                  obscureText: true,
                  validator: (input) {
                    setState(() {
                      pass = input;
                    });
                    if (input.length < 5) {
                      return "password lenght should be 6 or more";
                    } else if (pass != input) {
                      return "Passwords do not match";
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),

              // Confirm password
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  controller: nameHolder3,
                  obscureText: true,
                  validator: (input) {
                    if (input.length < 5) {
                      return "password lenght should be 6 or more";
                    } else if (pass != input) {
                      return "Passwords do not match";
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: "Confirm Password"),
                ),
              ),

              // Circular progress bar indicator to give a feel for time taken to sign up.
              SizedBox(height: 15),
              loading == true && _email != null && _password.length > 2
                  ? CircularProgressIndicator()
                  : Container(),

              // Sign Up button.
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: RaisedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    signIn();
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
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              (successMessage != ''
                  ? Text(
                      successMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                      ),
                    )
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

// Clearing the text fields after successful/unsuccessful sign up.
  final nameHolder = TextEditingController();
  final nameHolder2 = TextEditingController();
  final nameHolder3 = TextEditingController();
  clearTextInput() {
    nameHolder.clear();
    nameHolder2.clear();
    nameHolder3.clear();
  }

  // Sign up
  Future<void> signIn() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final formState = _formstate.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        UserCredential result =
            (await _firebaseAuth.createUserWithEmailAndPassword(
                email: _email, password: _password));
        print(result);
        User user = result.user;
        print("User details");
        print(result.user.uid);
        assert(result != null);
        assert(await result.user.getIdToken != null);
        print(user);
        prefs.setString('email', result.user.email);
        prefs.setString('uid', result.user.uid);
        uid = result.user.uid;

        // Initializing firestore with enail and empty link array.
        users.document(uid).setData(
          {
            "mailId": _email,
            "links": FieldValue.arrayUnion([null]),
          },
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SplashScreen()));
      } catch (e) {
        print("catch $e");
        Fluttertoast.showToast(
            msg:
                "We cannot sign you up with these credentials.\nPlease try again with new email id.");
        setState(() {
          loading = false;
        });
      }
    }
  }
}
