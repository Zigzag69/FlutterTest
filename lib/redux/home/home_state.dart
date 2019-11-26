import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class HomePageState extends Equatable {
  final bool isLoading;
  final Object sError;
  final Object bError;
  final String result;
  final String index;
  final List<User> newUsers;
  final List<User> users;

  HomePageState({
    this.isLoading,
    this.sError,
    this.bError,
    this.result,
    this.index,
    this.users,
    this.newUsers,
  }) : super([
          isLoading,
          sError,
          bError,
          result,
          index,
          users,
          newUsers,
        ]);

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      sError: '',
      bError: '',
      result: '',
      index: '',
      users: [],
      newUsers: [],
    );
  }

  HomePageState copyWith({
    bool isLoading,
    Object sError,
    Object bError,
    String result,
    String index,
    List<User> users,
    List<User> newUsers,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      sError: sError ?? this.sError,
      bError: bError ?? this.bError,
      result: result ?? this.result,
      index: index ?? this.index,
      users: users ?? this.users,
      newUsers: newUsers ?? this.newUsers,
    );
  }

  bool isDefault() {
    return isLoading == false &&
        sError == '' &&
        bError == '' &&
        result == '' &&
        index == '' &&
        users.isEmpty &&
        newUsers.isEmpty;
  }
}
