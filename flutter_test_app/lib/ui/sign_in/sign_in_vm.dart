import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';

@immutable
class SignInPageViewModel extends Equatable {
  SignInPageViewModel() : super([]);

  static SignInPageViewModel fromStore(Store<AppState> store) {
    return SignInPageViewModel();
  }
}