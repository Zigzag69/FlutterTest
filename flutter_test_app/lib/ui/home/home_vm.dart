import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';

@immutable
class HomePageViewModel extends Equatable {
  HomePageViewModel() : super([]);

  static HomePageViewModel fromStore(Store<AppState> store) {
    return HomePageViewModel();
  }
}