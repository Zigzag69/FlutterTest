import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';

class HomeMiddleware {
  final AuthRepo authRepo;
  HomeMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, RemoveItem>(_removeItem),
    ];
  }

  Future _removeItem(
    Store<AppState> store,
    RemoveItem action,
    NextDispatcher next,
  ) async {
    next(action);
    authRepo.deleteData(action.document).then((result) {
      store.dispatch(ShowResult());
    }).catchError((error) {
      print(error);
      store.dispatch(ShowError(error));
    });
  }
}
