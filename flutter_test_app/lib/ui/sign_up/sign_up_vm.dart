import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_actions.dart';

@immutable
class SignUpPageViewModel extends Equatable {
  SignUpPageViewModel() : super([]);

  static SignUpPageViewModel fromStore(Store<AppState> store) {
    return SignUpPageViewModel();
  }
}