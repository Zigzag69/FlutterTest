import 'package:flutter/services.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class AuthRepo {
  String messageNetworkError =
      "Something went wrong. Please check your internet and try again";

  Future<List<User>> getUsers() async {
    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("users").getDocuments();
    List<DocumentSnapshot> users = querySnapshot.documents;
    List<User> usersList = List();
    users.forEach((item) {
      usersList.add(User.fromJson(item.data));
    });
    return usersList;
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    final AuthResult authResult =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final FirebaseUser user = authResult.user;
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('user', true);
    return user;
  }

  Future<void> createUsers(
    String firstName,
    String lastName,
    int age,
    String id,
  ) async {
//    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    Firestore.instance.collection("users").document(id).setData({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'id': id,
    });
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    final AuthResult authResult =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final FirebaseUser user = authResult.user;
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('user', true);
    return user;
  }

  Future<void> deleteData(
    String id,
  ) async {
//    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    await Firestore.instance.collection('users').document(id).delete();
  }

  Future<void> updateData(
    DocumentSnapshot document,
    String newName,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    await document.reference.updateData({'names': newName});
  }
}
