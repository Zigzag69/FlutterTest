import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/redux/item_details/item_details_state.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';

@immutable
class ItemDetailsViewModel extends Equatable {
  final bool loading;
  final Object error;
  final Function(String id, String firstName) updateItem;
  final bool isDefault;
  final Function() resetState;
  ItemDetailsViewModel({
    this.loading,
    this.error,
    this.updateItem,
    this.isDefault,
    this.resetState,
  }) : super([
          loading,
          error,
          isDefault,
        ]);

  static ItemDetailsViewModel fromStore(Store<AppState> store) {
    final ItemDetailsState state = store.state.itemDetailsState;

    return ItemDetailsViewModel(
      loading: state.isLoading,
      error: state.error,
      updateItem: (id, firstName) =>
          store.dispatch(UpdateItem(id, firstName)),
      isDefault: state.isDefault(),
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
