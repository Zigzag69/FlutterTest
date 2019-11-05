import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_reducer.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_reducer.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_reducer.dart';
import 'package:flutter_test_app/redux/welcome/welcome_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      welcomePageState: welcomePageReducer(state.welcomePageState, action),
      signInPageState: signInPageReducer(state.signInPageState, action),
      signUpPageState: signUpPageReducer(state.signUpPageState, action),
      homePageState: homePageReducer(state.homePageState, action));
}