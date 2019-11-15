import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_actions.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';

class SignUpMiddleware {
  final AuthRepo authRepo;
  SignUpMiddleware(this.authRepo);

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
    await authRepo.signUp(action.email, action.password).then((login) {
      store.dispatch(ShowResult(action.email, action.password));
    }).catchError((error) {
      print(error);
      store.dispatch(ShowError(error));
    });
  }
}