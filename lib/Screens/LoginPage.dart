//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_printer/Screens/HomePage.dart';
import 'package:smart_printer/Screens/RegistrationPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _formKey = GlobalKey<FormState>();
  final _emailcontroller = new TextEditingController();
  final _passwdcontroller = new TextEditingController();
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwdcontroller.text.trim());
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    } on FirebaseAuthException catch (E) {
      Fluttertoast.showToast(
          msg: 'User does not exist',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    print(googleUser.email);

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      var ref = FirebaseFirestore.instance
          .collection('Users Details')
          .doc(googleUser.email);
      print('Document ID: ${ref.id}');

      await ref.set({
        'NAME': "your name",
        'CONTACT': "9090909069",
        'BRANCH': "CMPN",
        'DIVISION': "C",
        'LIB-CARD_NO': "696969"
      });
      print('Document created successfully');

      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      Fluttertoast.showToast(
        msg: 'User does not exist',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    // return const HomePage();
  }

  Future logout() async {
    await googleSignIn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(colors:[Color(0xFFEDAEF9),Color(0xFF81B1FA)])
                gradient: LinearGradient(
                    colors: [Color(0xFFA0B5EB), Color(0xFFC9F0E4)])),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Smart Printer',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Login To Your Account',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelText: 'E-mail',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _passwdcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      signIn();

                      // Navigator.pop(context);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const HomePage();
                      // }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5200FF),
                    ),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Login With',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          icon: Image.asset('assets/images/google.png'),
                          onPressed: () {
                            googleLogin();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          icon: Image.asset('assets/images/facebook.png'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      width: 75,
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          icon: Image.asset('assets/images/twitter.png'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: const Text(
                        "Create one",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
