import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class AuthRepo {
  bool network = false;
  String messageNetworkError =
      "Something went wrong. Please check your internet and try again";

  Future<void> checkInternet() async {
    print("check int");
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      print("not int $ConnectivityResult");
      network = false;
    } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      print("have int $ConnectivityResult");
      network = true;
    } else {
      network = false;
      print("error $ConnectivityResult");
    }
  }

  Future<List<ListUsers>> getUsers() async {
    try {
      checkInternet();
      if (!network) {
        throw PlatformException(
          code: "Test error code",
          message: messageNetworkError,
        );
      }

      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("users").getDocuments();
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
    checkInternet();
    if (!network) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

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

  Future<void> createUsers(
    String firstName,
    String lastName,
    int age,
  ) async {
    try {
//      var result = await Connectivity().checkConnectivity();
//      if (result == ConnectivityResult.none) {
//        print("throw PlatformException");
//        throw PlatformException(
//          code: "Test error code",
//          message: messageNetworkError,
//        );
//      }

      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );

      Firestore.instance.collection("users").document().setData({
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
      });
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    checkInternet();
    if (!network) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

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
    checkInternet();
    if (!network) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

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
    checkInternet();
    if (!network) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    try {
      await document.reference.updateData({'names': newName});
    } catch (error) {
      throw error.toString();
    }
  }
}
