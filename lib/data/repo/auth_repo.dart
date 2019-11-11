import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  Future<void> signIn(
    String email,
    String password,
  ) async {
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
      document.reference.delete();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> updateData(
    DocumentSnapshot document,
    String newName,
  ) async {
    try {
      document.reference.updateData({'names': newName});
    } catch (error) {
      throw error.toString();
    }
  }
}
