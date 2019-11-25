import 'package:flutter_test_app/data/models/user.dart';
import 'package:flutter_test_app/redux/home/home_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_state.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';

@immutable
class ItemDetailsViewModel extends Equatable {
  final bool loading;
  final String result;
  final Object error;
  final Function(String id, String firstName) updateItem;
  final bool isDefault;
  final Function() resetState;
  final List<User> users;

  ItemDetailsViewModel({
    this.loading,
    this.result,
    this.error,
    this.updateItem,
    this.isDefault,
    this.resetState,
    this.users,
  }) : super([
          loading,
          error,
          isDefault,
          users,
          result,
        ]);

  static ItemDetailsViewModel fromStore(Store<AppState> store) {
    final HomePageState homePageState = store.state.homePageState;
    final ItemDetailsState itemDetailsState = store.state.itemDetailsState;

    return ItemDetailsViewModel(
      result: itemDetailsState.result,
      loading: itemDetailsState.isLoading,
      error: itemDetailsState.error,
      users: homePageState.users,
      updateItem: (id, firstName) => store.dispatch(UpdateItem(id, firstName)),
      isDefault: itemDetailsState.isDefault(),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
