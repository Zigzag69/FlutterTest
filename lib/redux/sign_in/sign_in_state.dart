import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SignInPageState extends Equatable {
  final bool isLoading;
  final String email;
  final String password;
  final Object error;
  SignInPageState({this.isLoading, this.email, this.password, this.error})
      : super([isLoading, email, password, error]);

  factory SignInPageState.initial() {
    return SignInPageState(isLoading: false, email: '', password: '', error: '');
  }

  SignInPageState copyWith({
    bool isLoading,
    String email,
    String password,
    Object error,
  }) {
    return SignInPageState(
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
