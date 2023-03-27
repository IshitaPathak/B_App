import 'dart:math';

import 'package:chat_app/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/services/databse_services.dart';

class Authservices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login function
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        //call our database services to update the user data
        // await DatabaseServices(uid: user.uid).updateUserData(email);
        return true;
      }
      // await DatabaseServices(uid: user.uid).updateUserData(fullname, email);
      // return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //register function
  Future registerUserWithEmailandPassword(
      String fullname, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        //call our database services to update the user data
        await DatabaseServices(uid: user.uid).savingUserData(fullname, email);
        return true;
      }
      // await DatabaseServices(uid: user.uid).updateUserData(fullname, email);
      // return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //signuout function
  Future signOut() async {
    try {
      await HelperFunction.savedUserLoggedInStatus(false);
      await HelperFunction.savedUserEmail("");
      await HelperFunction.savedUserName("");

      //If you have written this signout is done but above three line is to remove data from shared preferences
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
