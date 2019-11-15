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
      TypedMiddleware<AppState, GetUsers>(_getUsers),
    ];
  }

  Future _removeItem(
      Store<AppState> store,
      RemoveItem action,
      NextDispatcher next,
      ) async {
    next(action);
    await authRepo.deleteData(action.document).then((result) {
      store.dispatch(ShowResult());
    }).catchError((error) {
      print(error);
      store.dispatch(ShowError(error));
    });
  }

  Future _getUsers(
      Store<AppState> store,
      GetUsers action,
      NextDispatcher next,
      ) async {
    next(action);
    await authRepo.getUsers().then((result) {
      print("SUCCESS ${result}");
      store.dispatch(ShowResult());
    }).catchError((error) {
      print("ERROR ${error}");
      store.dispatch(ShowError(error));
    });
  }
}
