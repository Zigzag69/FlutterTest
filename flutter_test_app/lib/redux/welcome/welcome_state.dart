import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class WelcomeState extends Equatable {
  WelcomeState() : super([]);

  factory WelcomeState.initial() {
    return WelcomeState();
  }

  WelcomeState copyWith() {
    return WelcomeState();
  }
}