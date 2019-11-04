import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/redux/welcome/welcome_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_state.dart';

@immutable
class AppState extends Equatable {
  final WelcomePageState welcomePageState;
  final SignInPageState signInPageState;
  AppState({
    this.welcomePageState,
    this.signInPageState,
  }) : super([
    welcomePageState,
    signInPageState,
  ]);

  factory AppState.initial() {
    return AppState(
      welcomePageState: WelcomePageState.initial(),
      signInPageState: SignInPageState.initial(),
    );
  }

  AppState copyWith({
    WelcomePageState welcomeState,
    SignInPageState signInPageState,
  }) {
    return AppState(
      welcomePageState: welcomeState ?? this.welcomePageState,
      signInPageState: signInPageState ?? this.signInPageState,
    );
  }
}