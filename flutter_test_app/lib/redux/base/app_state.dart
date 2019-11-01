import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/redux/welcome/welcome_state.dart';

@immutable
class AppState extends Equatable {
  final WelcomePageState welcomePageState;
  AppState({
    this.welcomePageState,
  }) : super([
    welcomePageState,
  ]);

  factory AppState.initial() {
    return AppState(
      welcomePageState: WelcomePageState.initial(),
    );
  }

  AppState copyWith({
    WelcomePageState welcomeState,
  }) {
    return AppState(
      welcomePageState: welcomeState ?? this.welcomePageState,
    );
  }
}