import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';

class SignInMiddleware {
  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, SignIn>(_signIn),
    ];
  }

  Future _signIn(
    Store<AppState> store,
    SignIn action,
    NextDispatcher next,
  ) async {
    next(action);
    try {
      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: action.email, password: action.password))
          .user;
      store.dispatch(ShowResult(action.email, action.password));
    } catch (error) {
      store.dispatch(ShowError(error));
      print(error.toString());
    }
  }
}
