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

  Future<void> createUsers(List<User> usersList) async {
    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    for (var i = 0; i < usersList.length; i++) {
       Firestore.instance
          .collection("users")
          .document(usersList[i].id)
          .setData({
        'firstName': usersList[i].firstName,
        'lastName': usersList[i].lastName,
        'age': usersList[i].age,
        'id': usersList[i].id,
      });
    }
  }

  Future<void> deleteData(
    String id,
  ) async {
    await Future.delayed(Duration(seconds: 1));
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
    String id,
    String firstName,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      throw PlatformException(
        code: "Test error code",
        message: messageNetworkError,
      );
    }

    await Firestore.instance
        .collection('users')
        .document(id)
        .updateData({'firstName': firstName});
  }
}
