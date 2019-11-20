import 'dart:async';
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
    await authRepo.deleteData(action.id).then((result) async {
      await authRepo.getUsers().then((usersList) {
        store.dispatch(ShowUsersAction(usersList, ''));
      }).catchError((error) {
        store.dispatch(ShowUsersAction([], error));
      });
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
      store.dispatch(ShowUsersAction([], error));
    });
  }

  Future _createUsers(
    Store<AppState> store,
    CreateUsers action,
    NextDispatcher next,
  ) async {
    next(action);
    for (var i = 0; i < 10; i++) {
      var randomFirstName = randomString(5);
      var randomLastName = randomString(5);
      var randomAge = randomBetween(5, 100);
      var randomId = Uuid.v1().time.toString();
      await authRepo
          .createUsers(randomFirstName, randomLastName, randomAge, randomId)
          .then((result) async {
        if (i == 9) {
          await authRepo.getUsers().then((usersList) {
            store.dispatch(ShowUsersAction(usersList, ''));
            print(usersList);
          }).catchError((error) {
            store.dispatch(ShowUsersAction([], error));
          });
        }
      }).catchError((error) {
        print(error);
        store.dispatch(ShowSError(error));
      });
    }
  }
}
