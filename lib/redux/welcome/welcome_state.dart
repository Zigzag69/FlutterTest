import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class WelcomePageState extends Equatable {
  WelcomePageState() : super([]);

  factory WelcomePageState.initial() {
    return WelcomePageState();
  }

  WelcomePageState copyWith() {
    return WelcomePageState();
  }
}