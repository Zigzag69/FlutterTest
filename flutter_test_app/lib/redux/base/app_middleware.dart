import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_middleware.dart';

List<Middleware<AppState>> appMiddleware(
    ) {
  final appMiddleware = <Middleware<AppState>>[];
  appMiddleware.addAll(SignInMiddleware().getMiddleware());
  return appMiddleware;
}