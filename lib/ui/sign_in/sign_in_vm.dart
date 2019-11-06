import 'dart:math';

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
    return SignInPageViewModel(
      loading: store.state.signInPageState.isLoading,
      email: store.state.signInPageState.email,
      password: store.state.signInPageState.password,
      error: store.state.signInPageState.error,
      signIn: (email, password) => store.dispatch(SignIn(email, password)),
      isDefault: store.state.signInPageState.isLoading,
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
