import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SignUpPageState extends Equatable {
  SignUpPageState() : super([]);

  factory SignUpPageState.initial() {
    return SignUpPageState();
  }

  SignUpPageState copyWith() {
    return SignUpPageState();
  }
}