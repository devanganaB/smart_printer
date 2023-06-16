import 'package:flutter/material.dart';
import 'package:smart_printer/Screens/LoginPage.dart';
import 'package:smart_printer/Screens/RegistrationPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  bool showloginpage = true;
  @override
  Widget build(BuildContext context) {
    if (showloginpage) {
      return LoginPage();
    } else {
      return RegisterPage();
    }
  }
}
