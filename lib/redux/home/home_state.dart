import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class HomePageState extends Equatable {
  final bool isLoading;
  final Object sError;
  final Object bError;
  final List<User> users;

  HomePageState({
    this.isLoading,
    this.sError,
    this.bError,
    this.users,
  }) : super([
          isLoading,
          sError,
          bError,
          users,
        ]);

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      sError: '',
      bError: '',
      users: [],
    );
  }

  HomePageState copyWith({
    bool isLoading,
    Object sError,
    Object bError,
    List<User> users,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      sError: sError ?? this.sError,
      bError: bError ?? this.bError,
      users: users ?? this.users,
    );
  }

  bool isDefault() {
    return isLoading == false &&
        sError == '' &&
        bError == '' &&
        users == [];
  }
}
