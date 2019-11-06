import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';

class SignInMiddleware {
  final AuthRepo authRepo;
  SignInMiddleware(this.authRepo);

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
    authRepo.signIn(action.email, action.password).then((login) {
      store.dispatch(ShowResult(action.email, action.password));
    }).catchError((error) {
      print(error);
      store.dispatch(ShowError(error));
    });
  }
}
