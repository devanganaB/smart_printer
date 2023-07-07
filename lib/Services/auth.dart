import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // // sign in with email and password
  // Future signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //modified sign in code
  //      //-----------------------------CODE1------------------------
  // Future signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;

  //     // Store the user's authentication token in SharedPreferences
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('userToken', result.user!.uid);

  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  //    //------------------------------------------------------------

  //-------------------------CODE2-------------------------------
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Store the user's authentication token securely
      final storage = FlutterSecureStorage();
      await storage.write(key: 'userToken', value: result.user!.uid);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //------------------------------------------------------------------

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // // sign out
  // Future signOut() async {
  //   try {
  //     return await _auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //modfied sign out
  //    //----------------CODE1-------------------------
  // Future signOut() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.remove('userToken');
  //     return await _auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  //   //--------------------------------------------------

  //--------------------------------CODE2-----------------------------
  Future signOut() async {
    try {
      final storage = FlutterSecureStorage();
      await storage.delete(key: 'userToken');
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //-----------------------------------------------------------------
}
