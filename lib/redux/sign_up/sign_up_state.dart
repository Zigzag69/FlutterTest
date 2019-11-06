import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SignUpPageState extends Equatable {
  final bool isLoading;
  final String email;
  final String password;
  final Object error;
  SignUpPageState({
    this.isLoading,
    this.email,
    this.password,
    this.error,
  }) : super([isLoading, email, password, error]);

  factory SignUpPageState.initial() {
    return SignUpPageState(
      isLoading: false,
      email: '',
      password: '',
      error: '',
    );
  }

  SignUpPageState copyWith({
    bool isLoading,
    String email,
    String password,
    Object error,
  }) {
    return SignUpPageState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }

  bool isDefault() {
    return isLoading == false && email == '' && password == '' && error == '';
  }
}
