import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SignInPageState extends Equatable {
  SignInPageState() : super([]);

  factory SignInPageState.initial() {
    return SignInPageState();
  }

  SignInPageState copyWith() {
    return SignInPageState();
  }
}