import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class SignInPageState extends Equatable {
  final bool isLoading;
  final String email;
  final Object error;
  SignInPageState({
    this.isLoading,
    this.email,
    this.error,
  }) : super([isLoading, email, error]);

  factory SignInPageState.initial() {
    return SignInPageState(
      isLoading: false,
      email: '',
      error: '',
    );
  }

  SignInPageState copyWith({
    bool isLoading,
    String email,
    Object error,
  }) {
    return SignInPageState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      error: error ?? this.error,
    );
  }

  bool isDefault() {
    return isLoading == false && email == '' && error == '';
  }
}
