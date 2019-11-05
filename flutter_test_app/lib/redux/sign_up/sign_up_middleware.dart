import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_actions.dart';

class SignUpMiddleware {
  SignUpMiddleware();

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, SignUp>(_signUp),
    ];
  }

  Future _signUp(
      Store<AppState> store,
      SignUp action,
      NextDispatcher next,
      ) async {
    next(action);
    try {
      FirebaseUser user = (await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: action.email, password: action.password))
          .user;
      store.dispatch(ShowResult(action.email, action.password));
    } catch (error) {
      store.dispatch(ShowError(error));
      print(error.toString());
    }
  }
}