import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<User> users;

  final Function() clearSError;
  final Function() resetState;
  final Function() getUsers;
  final Function() createUsers;
  final Function(String id) removeItem;

  HomePageViewModel({
    this.loading,
    this.sError,
    this.bError,
    this.isDefault,
    this.users,

    this.clearSError,
    this.resetState,
    this.getUsers,
    this.createUsers,
    this.removeItem,
  }) : super([
          loading,
          sError,
          bError,
          isDefault,
          users,
        ]);

  static HomePageViewModel fromStore(Store<AppState> store) {
    final HomePageState state = store.state.homePageState;

    return HomePageViewModel(
      loading: state.isLoading,
      sError: state.sError,
      bError: state.bError,
      isDefault: state.isDefault(),
      users: state.users,
      clearSError: () => store.dispatch(ClearSError),
      removeItem: (id) => store.dispatch(RemoveItem(id)),
      getUsers: () => store.dispatch(GetUsers()),
      createUsers: () => store.dispatch(CreateUsers()),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
