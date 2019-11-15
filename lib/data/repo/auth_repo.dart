import 'package:flutter/services.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {


  Future<List<User>> getUsers() async {
//    bool network = false;
//    if (!network) {
//      throw PlatformException(
//        code: "Test error code",
//        message: "Test error message",
//      );
//    }

    try {
      final firestore = Firestore.instance;
      QuerySnapshot querySnapshot = await firestore.collection("users").getDocuments();
      List<dynamic> users = querySnapshot.documents;

//      final User user = User.fromJson(users);

      print("USER = ${users}");
     return users;
    } catch (error) {
      print("ERROR");
      throw error.toString();
    }
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    //    bool network = false;
//    if (!network) {
//      throw PlatformException(
//        code: "Test error code",
//        message: "Test error message",
//      );
//    }

    try {
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final FirebaseUser user = authResult.user;
      final sp = await SharedPreferences.getInstance();
      await sp.setBool('user', true);
      return user;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    //    bool network = false;
//    if (!network) {
//      throw PlatformException(
//        code: "Test error code",
//        message: "Test error message",
//      );
//    }

    try {
      final AuthResult authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final FirebaseUser user = authResult.user;
      final sp = await SharedPreferences.getInstance();
      await sp.setBool('user', true);
      return user;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> deleteData(
    DocumentSnapshot document,
  ) async {
    try {
      await document.reference.delete();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> updateData(
    DocumentSnapshot document,
    String newName,
  ) async {
    try {
      await document.reference.updateData({'names': newName});
    } catch (error) {
      throw error.toString();
    }
  }
}
