import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/welcome/welcome_actions.dart';

@immutable
class WelcomePageViewModel extends Equatable {
  WelcomePageViewModel() : super([]);

  static WelcomePageViewModel fromStore(Store<AppState> store) {
    return WelcomePageViewModel();
  }
}