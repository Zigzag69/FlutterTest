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
  final Function(DocumentSnapshot document, String newName) removeItem;
  final bool isDefault;
  final Function() resetState;
  HomePageViewModel({
    this.loading,
    this.error,
    this.removeItem,
    this.isDefault,
    this.resetState,
  }) : super([
          loading,
          error,
          isDefault,
        ]);

  static HomePageViewModel fromStore(Store<AppState> store) {
    return HomePageViewModel(
      loading: store.state.homePageState.isLoading,
      error: store.state.homePageState.error,
      removeItem: (document, newName) => store.dispatch(RemoveItem(document, newName)),
      isDefault: store.state.homePageState.isLoading,
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
