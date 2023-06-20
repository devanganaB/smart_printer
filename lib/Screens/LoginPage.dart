import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_printer/Screens/HomePage.dart';
import 'package:smart_printer/Screens/RegistrationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_printer/Services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = new TextEditingController();
  final TextEditingController _passwdcontroller = new TextEditingController();

  // Future signIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailcontroller.text.trim(),
  //         password: _passwdcontroller.text.trim());
  //     Navigator.pop(context);
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return const HomePage();
  //     }));
  //   } on FirebaseAuthException catch (E) {
  //     Fluttertoast.showToast(
  //         msg: 'User does not exist',
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

  //modified sign in
  //      //---------------------CODE1----------------------------
  // Future signIn() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? userToken = prefs.getString('userToken');

  //     if (userToken != null) {
  //       // If the user token exists, directly navigate to the Home page
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     } else {
  //       // If the user token doesn't exist, perform the sign-in process
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailcontroller.text.trim(),
  //         password: _passwdcontroller.text.trim(),
  //       );
  //       User? user = FirebaseAuth.instance.currentUser;
  //       if (user != null) {
  //         // Store the user's authentication token in SharedPreferences
  //         await prefs.setString('userToken', user.uid);
  //       }
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     Fluttertoast.showToast(
  //       msg: 'User does not exist',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }
  //    //---------------------------------------------------------------

  //------------------------CODE2--------------------------------
  final Auth _auth = Auth();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwdcontroller.dispose();
    super.dispose();
  }
  //--------------------------------------------------------------

  Future<void> signIn() async {
    //   //----------------CODE1-------------------------
    // try {
    //   final storage = FlutterSecureStorage();
    //   String? userToken = await storage.read(key: 'userToken');

    //   if (userToken != null) {
    //     // If the user token exists, directly navigate to the Home page
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const HomePage()),
    //     );
    //   } else {
    //     // If the user token doesn't exist, perform the sign-in process
    //     await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: _emailcontroller.text.trim(),
    //       password: _passwdcontroller.text.trim(),
    //     );
    //     User? user = FirebaseAuth.instance.currentUser;
    //     if (user != null) {
    //       // Store the user's authentication token securely
    //       await storage.write(key: 'userToken', value: user.uid);
    //     }
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const HomePage()),
    //     );
    //   }
    //    //-----------------------------------------------------------

    //----------------------CODE2----------------------
    try {
      User? user = await _auth.signInWithEmailAndPassword(
        _emailcontroller.text.trim(),
        _passwdcontroller.text.trim(),
      );
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
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
    } on FirebaseAuthException catch (e) {
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
  }
  //-------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    //---------CHANGES IN RETURN--------
    return WillPopScope(
      onWillPop: () async {
        // Disable the back button
        return false;
      },
      child: Scaffold(
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
      ),
    );
  }
}
