import 'package:draw_it_app/anotherPage.dart';
import 'package:draw_it_app/initialScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Signin"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
              TextFormField(
                validator: (input) {
                  if (input.length < 2) {
                    return "Please is small";
                  }
                },
                onSaved: (input) {
                  _password = input;
                },
                decoration: InputDecoration(labelText: "Password"),
              ),
              RaisedButton(
                onPressed: () {
                  signin();
                },
                child: Text(
                  "Sign in",
                ),
              ),
              RaisedButton(
                onPressed: () {
                  // googleSignIn(context);
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
                      Icon(Icons.g_translate),
                      SizedBox(width: 20),
                      Text("Sign in with google"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Future<void> signin() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        print("aw");
        UserCredential result = (await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password));
        print("aiting");
        print(result);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => SplashScreen()));
      } catch (e) {
        print("catch $e");
      }
    }
  }

  // Future<FirebaseUser> googleSignIn(BuildContext context) async {
  //   FirebaseUser currentUse;
  //   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //   try {
  //     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication googleauth =
  //         await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.getCredential(
  //         idToken: googleauth.idToken, accessToken: googleauth.accessToken);
  //     final FirebaseUser user =
  //         (await _firebaseAuth.signInWithCredential(credential)).user;
  //     assert(user.email != null);
  //     assert(user.displayName != null);
  //     assert(!user.isAnonymous);
  //     assert(await user.getIdToken() != null);

  //     currentUse = await _firebaseAuth.currentUser;
  //     assert(user.uid == currentUse.uid);
  //     print(currentUse);
  //     print("username = ${currentUse.displayName}");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SplashScreen(),
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  //   return currentUse;
  // }
}
