import 'package:redux/redux.dart';

import 'package:flutter_test_app/redux/base/app_reducer.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';


Future<Store<AppState>> appStore(sharedPreferences) async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
  );
}