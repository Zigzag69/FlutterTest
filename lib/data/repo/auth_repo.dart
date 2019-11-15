import 'package:flutter/services.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  Future<List<ListUsers>> getUsers() async {
    try {
      //    bool network = false;
//    if (!network) {
//      throw PlatformException(
//        code: "Test error code",
//        message: "Test error message",
//      );
//    }

      QuerySnapshot querySnapshot = await Firestore.instance.collection("users").getDocuments();
      List<DocumentSnapshot> users = querySnapshot.documents;
      List<ListUsers> usersList = List();
      users.forEach((item) {
        usersList.add(User.fromJson(item.data));
      });
      print("DOCENT LISTUSERS ${User}");
     return usersList;
    } catch (error) {
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
