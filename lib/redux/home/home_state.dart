import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class HomePageState extends Equatable {
  final bool isLoading;
  final Object error;
  final List<ListUsers> users;
  HomePageState({
    this.isLoading,
    this.error,
    this.users,
  }) : super([
          isLoading,
          error,
          users,
        ]);

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      error: '',
      users: List(),
    );
  }

  HomePageState copyWith({
    bool isLoading,
    Object error,
    List<ListUsers> users,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      users: users ?? this.users,
    );
  }

  bool isDefault() {
    return isLoading == false && error == '' && users == List();
  }
}
