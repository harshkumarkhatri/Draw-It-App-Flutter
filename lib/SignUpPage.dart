import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final _confirmPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text("Sign up page"),
      ),
      body: Form(
        key: _formstate,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(top: 50, bottom: 10, right: 10, left: 10),
                child: TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Email cannot be empty";
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    icon: Icon(Icons.mail_outline),
                    helperText: "Enter your email",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (input) {
                    if (input.length < 5) {
                      return "password lenght should be 6 or more";
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    helperText: "Enter you password",
                    labelText: "Password",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (input) {
                    if (input.trim() != _passwordController.text.trim()) {
                      return "passwords do not match";
                    }
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    helperText: "Enter you password",
                    labelText: "Confirm Password",
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  signIn(_email, _password).then((user) {
                    if (user != null) {
                      print("success");
                      setState(() {
                        successMessage =
                            "Registered successfully. \n You can now login";
                      });
                    } else {
                      setState(() {
                        successMessage = "Error registering";
                      });
                      print("Error registering");
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  child: Text(
                    "Sign up",
                    style: TextStyle(fontSize: 20),
                  ),
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
                  padding: const EdgeInsets.all(10.0),
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

  Future<User> signIn(email, password) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final formState = _formstate.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        UserCredential result = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password));
        print(result);
        User user = result.user;
        print(result.user.uid);
        print(result.user.getIdToken());
        assert(result != null);
        assert(await result.user.getIdToken != null);
        // print(user);
        return user;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
}
