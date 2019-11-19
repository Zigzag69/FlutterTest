import 'dart:math';

import 'package:flutter_test_app/redux/sign_in/sign_in_state.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';

@immutable
class SignInPageViewModel extends Equatable {
  final bool loading;
  final String email;
  final String password;
  final Object error;
  final Function(String, String) signIn;
  final bool isDefault;
  final Function() resetState;
  SignInPageViewModel({
    this.loading,
    this.email,
    this.password,
    this.error,
    this.signIn,
    this.isDefault,
    this.resetState,
  }) : super([
          loading,
          email,
          password,
          error,
          isDefault,
        ]);

  static SignInPageViewModel fromStore(Store<AppState> store) {
    final SignInPageState state = store.state.signInPageState;

    return SignInPageViewModel(
      loading: state.isLoading,
      email: state.email,
      password: state.password,
      error: state.error,
      signIn: (email, password) => store.dispatch(SignIn(email, password)),
      isDefault: state.isDefault(),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
