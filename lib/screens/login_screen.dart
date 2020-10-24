import 'package:RPPost/common/dark%20mode/dark_theme_provider.dart';
import 'package:RPPost/common/widgets/rounded_button.dart';
import 'package:RPPost/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'RPPost',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    TextFieldDecoration.copyWith(hintText: 'Enter your email'),
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: TextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
                style: TextStyle(color: Colors.black),
              ),
              RoundedButton(
                text: 'Log In',
                onPressed: () async {
                  setState(
                    () {
                      showSpinner = true;
                    },
                  );
                  try {
                    final loggedInUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (loggedInUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(
                      () {
                        showSpinner = false;
                      },
                    );
                  } catch (e) {
                    print(e);
                    setState(
                      () {
                        showSpinner = false;
                      },
                    );
                  }
                },
                color: Colors.lightBlueAccent,
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                text: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                color: Colors.blueAccent,
              ),
              Checkbox(
                value: themeChange.darkTheme,
                onChanged: (bool value) {
                  themeChange.darkTheme = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
