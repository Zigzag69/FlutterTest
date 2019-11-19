import 'package:flutter_test_app/redux/sign_up/sign_up_state.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_actions.dart';

@immutable
class SignUpPageViewModel extends Equatable {
  final bool loading;
  final String email;
  final String password;
  final Object error;
  final Function(String, String) signUp;
  final bool isDefault;
  final Function() resetState;
  SignUpPageViewModel({
    this.loading,
    this.email,
    this.password,
    this.error,
    this.signUp,
    this.isDefault,
    this.resetState,
  }) : super([
          loading,
          email,
          password,
          error,
          isDefault,
        ]);

  static SignUpPageViewModel fromStore(Store<AppState> store) {
    final SignUpPageState state = store.state.signUpPageState;

    return SignUpPageViewModel(
      loading: state.isLoading,
      email: state.email,
      password: state.password,
      error: state.error,
      signUp: (email, password) => store.dispatch(SignUp(email, password)),
      isDefault: state.isDefault(),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
