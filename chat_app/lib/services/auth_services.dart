import 'package:chat_app/helper/helper_function.dart';
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

      await DatabaseServices(uid: user.uid).updateUserData(fullname, email);
      return true;
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

      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
