import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with google
  Future signInWithCredential(OAuthCredential credential) async{
    try{
      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}