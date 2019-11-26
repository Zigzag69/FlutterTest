import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/data/models/user.dart';

@immutable
class HomePageViewModel extends Equatable {
  final bool loading;
  final Object sError;
  final Object bError;
  final bool isDefault;
  final String result;
  final String index;
  final List<User> users;
  final List<User> newUsers;

  final Function() clearSError;
  final Function() clearResult;
  final Function() resetState;
  final Function() getUsers;
  final Function() createUsers;
  final Function(String id, int index) removeItem;

  HomePageViewModel({
    this.loading,
    this.sError,
    this.bError,
    this.result,
    this.isDefault,
    this.index,
    this.users,
    this.newUsers,

    this.clearSError,
    this.clearResult,
    this.resetState,
    this.getUsers,
    this.createUsers,
    this.removeItem,
  }) : super([
          loading,
          sError,
          bError,
          result,
          isDefault,
          index,
          users,
          newUsers,
        ]);

  static HomePageViewModel fromStore(Store<AppState> store) {
    final HomePageState state = store.state.homePageState;

    return HomePageViewModel(
      loading: state.isLoading,
      sError: state.sError,
      bError: state.bError,
      result: state.result,
      index: state.index,
      users: state.users,
      newUsers: state.newUsers,
      isDefault: state.isDefault(),

      clearSError: () => store.dispatch(ClearSError()),
      clearResult: () => store.dispatch(ClearResult()),
      removeItem: (id, index) => store.dispatch(RemoveUser(id, index)),
      getUsers: () => store.dispatch(GetUsers()),
      createUsers: () => store.dispatch(CreateUsers()),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
