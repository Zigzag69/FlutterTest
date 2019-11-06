import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_reducer.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/base/app_middleware.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';

Future<Store<AppState>> appStore(sharedPreferences) async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: appMiddleware(
      AuthRepo(),
    ),
  );
}
