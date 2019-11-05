import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_actions.dart';

@immutable
class SignUpPageViewModel extends Equatable {
  final String email;
  final String password;
  final Object error;
  final Function(String, String) signUp;
  final bool isDefault;
  final Function() resetState;
  SignUpPageViewModel({
    this.email,
    this.password,
    this.error,
    this.signUp,
    this.isDefault,
    this.resetState,
  }) : super([email, password, error, isDefault]);

  static SignUpPageViewModel fromStore(Store<AppState> store) {
    return SignUpPageViewModel(
      email: store.state.signUpPageState.email,
      password: store.state.signUpPageState.password,
      error: store.state.signUpPageState.error,
      signUp: (email, password) => store.dispatch(SignUp(email, password)),
      isDefault: store.state.signUpPageState.isLoading,
      resetState: () => store.dispatch(ResetState()),
    );
  }
}