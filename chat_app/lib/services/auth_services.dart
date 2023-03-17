import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/services/databse_services.dart';

class Authservices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login function

  //register function
  Future registerUserWithEmailandPassword(
      String fullname, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        //call our database services to update the user data
        await DatabaseServices(uid: user.uid).updateUserData(fullname, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //signuout function
}
