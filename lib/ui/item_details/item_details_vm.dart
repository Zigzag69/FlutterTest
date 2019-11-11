import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';

@immutable
class ItemDetailsViewModel extends Equatable {
  final bool loading;
  final Object error;
  final Function(DocumentSnapshot document, String newName) updateItem;
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
    return ItemDetailsViewModel(
      loading: store.state.itemDetailsState.isLoading,
      error: store.state.itemDetailsState.error,
      updateItem: (document, newName) =>
          store.dispatch(UpdateItem(document, newName)),
      isDefault: store.state.itemDetailsState.isLoading,
      resetState: () => store.dispatch(ResetState()),
    );
  }
}
