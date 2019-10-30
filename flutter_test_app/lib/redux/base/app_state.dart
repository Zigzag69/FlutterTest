import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/redux/welcome/welcome_state.dart';

@immutable
class AppState extends Equatable {
  final WelcomeState welcomeState;
  AppState({
    this.welcomeState,
  }) : super([
    welcomeState,
  ]);

  factory AppState.initial() {
    return AppState(
      welcomeState: WelcomeState.initial(),
    );
  }

  AppState copyWith({
    WelcomeState loginState,
  }) {
    return AppState(
      welcomeState: loginState ?? this.welcomeState,
    );
  }
}