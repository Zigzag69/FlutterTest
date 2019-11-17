import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';
import 'dart:math' show Random;
import 'dart:convert';

class HomeMiddleware {
  final AuthRepo authRepo;
  HomeMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, RemoveItem>(_removeItem),
      TypedMiddleware<AppState, GetUsers>(_getUsers),
      TypedMiddleware<AppState, CreateUsers>(_createUsers),
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
      store.dispatch(ShowResult());
    }).catchError((error) {
      store.dispatch(ShowError(error));
    });
  }

  Future _createUsers(
    Store<AppState> store,
    CreateUsers action,
    NextDispatcher next,
  ) async {
    next(action);
    for(var i = 0; i < 10; i++) {
      var randomFirstName = randomString(5);
      var randomLastName = randomString(5);
      var randomAge = randomBetween(5, 100);
      await authRepo.createUsers(randomFirstName, randomLastName, randomAge).then((result) {
        store.dispatch(ShowResult());
      }).catchError((error) {
        print("test error home $error");
        store.dispatch(ShowError(error));
      });
    }
  }
}
