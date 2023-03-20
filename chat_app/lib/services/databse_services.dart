import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});
  //refrence for our collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");
  //saving the user data
  Future savingUserData(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

// getting user data
  Future gettingUserData(String email) async {
    var userCollection;
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
