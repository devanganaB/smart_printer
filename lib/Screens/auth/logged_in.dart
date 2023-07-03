import 'package:smart_printer/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/LoginPage.dart';
import 'package:smart_printer/Screens/auth/AuthPage.dart';

class LoggedIn extends StatelessWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData == FirebaseAuth.instance.currentUser) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
