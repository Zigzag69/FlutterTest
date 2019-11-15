import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class HomePageViewModel extends Equatable {
  final bool loading;
  final Object error;
  final Function(DocumentSnapshot document) removeItem;
  final bool isDefault;
  final Function() resetState;
  final Function() getUsers;
  HomePageViewModel({
    this.loading,
    this.error,
    this.removeItem,
    this.isDefault,
    this.resetState,
    this.getUsers,
  }) : super([
          loading,
          error,
          isDefault,
        ]);

  static HomePageViewModel fromStore(Store<AppState> store) {
    return HomePageViewModel(
      loading: store.state.homePageState.isLoading,
      error: store.state.homePageState.error,
      removeItem: (document) => store.dispatch(RemoveItem(document)),
      getUsers: () => store.dispatch(GetUsers()),
      isDefault: store.state.homePageState.isLoading,
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
