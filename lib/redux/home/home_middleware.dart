import 'dart:async';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';
import 'package:better_uuid/uuid.dart';

class HomeMiddleware {
  final AuthRepo authRepo;
  HomeMiddleware(this.authRepo);

  List<Middleware<AppState>> getMiddleware() {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, RemoveUser>(_removeUser),
      TypedMiddleware<AppState, GetUsers>(_getUsers),
      TypedMiddleware<AppState, CreateUsers>(_createUsers),
    ];
  }

  Future _removeUser(
    Store<AppState> store,
    RemoveUser action,
    NextDispatcher next,
  ) async {
    next(action);
    await authRepo.deleteData(action.id).then((result) {
      store.dispatch(ShowResult('remove', action.index.toString(), []));
    }).catchError((error) {
      print(error);
      store.dispatch(ShowSError(error));
    });
  }

  Future _getUsers(
    Store<AppState> store,
    GetUsers action,
    NextDispatcher next,
  ) async {
    next(action);
    await authRepo.getUsers().then((usersList) {
      store.dispatch(ShowUsersAction(usersList, ''));
    }).catchError((error) {
      print(error);
      store.dispatch(ShowUsersAction([], error));
    });
  }

  Future _createUsers(
    Store<AppState> store,
    CreateUsers action,
    NextDispatcher next,
  ) async {
    next(action);
    List<User> usersList = List();
//    for (var i = 0; i < 10; i++) {
    for (var i = 0; i < 1; i++) {
      var randomFirstName = randomString(5);
      var randomLastName = randomString(5);
      var randomAge = randomBetween(5, 100);
      var randomId = Uuid.v1().time.toString();
      usersList.add(User(
        firstName: randomFirstName,
        lastName: randomLastName,
        age: randomAge,
        id: randomId,
      ));
    }
    await authRepo.createUsers(usersList).then((result) {
      store.dispatch(ShowResult('create', '', usersList));
    }).catchError((error) {
      print(error);
      store.dispatch(ShowSError(error));
    });
  }
}
