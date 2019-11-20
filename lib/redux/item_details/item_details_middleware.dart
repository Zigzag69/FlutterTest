import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';

class ItemDetailsMiddleware {
  final AuthRepo authRepo;
  ItemDetailsMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, UpdateItem>(_updateItem),
    ];
  }

  Future _updateItem(
      Store<AppState> store,
      UpdateItem action,
      NextDispatcher next,
      ) async {
    next(action);
   await authRepo.updateData(action.id, action.firstName).then((result) {
      store.dispatch(ShowResult());
    }).catchError((error) {
      print(error);
      store.dispatch(ShowError(error));
    });
  }
}