import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/redux/welcome/welcome_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_state.dart';
import 'package:flutter_test_app/redux/home/home_state.dart';

@immutable
class AppState extends Equatable {
  final WelcomePageState welcomePageState;
  final SignInPageState signInPageState;
  final SignUpPageState signUpPageState;
  final HomePageState homePageState;
  AppState(
      {this.welcomePageState,
      this.signInPageState,
      this.signUpPageState,
      this.homePageState})
      : super([
          welcomePageState,
          signInPageState,
          signUpPageState,
          homePageState
        ]);

  factory AppState.initial() {
    return AppState(
        welcomePageState: WelcomePageState.initial(),
        signInPageState: SignInPageState.initial(),
        signUpPageState: SignUpPageState.initial(),
        homePageState: HomePageState.initial());
  }

  AppState copyWith(
      {WelcomePageState welcomeState,
      SignInPageState signInPageState,
      SignUpPageState signUpPageState,
      HomePageState homePageState}) {
    return AppState(
        welcomePageState: welcomeState ?? this.welcomePageState,
        signInPageState: signInPageState ?? this.signInPageState,
        signUpPageState: signUpPageState ?? this.signUpPageState,
        homePageState: homePageState ?? this.homePageState);
  }
}
