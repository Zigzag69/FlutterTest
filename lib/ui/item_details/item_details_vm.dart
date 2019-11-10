import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';

@immutable
class ItemDetailsViewModel extends Equatable {
  ItemDetailsViewModel() : super([]);

  static ItemDetailsViewModel fromStore(Store<AppState> store) {
    return ItemDetailsViewModel();
  }
}