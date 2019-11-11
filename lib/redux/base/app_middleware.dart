import 'package:flutter_test_app/redux/item_details/item_details_middleware.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_middleware.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_middleware.dart';
import 'package:flutter_test_app/data/repo/auth_repo.dart';
import 'package:flutter_test_app/redux/home/home_middleware.dart';

List<Middleware<AppState>> appMiddleware(
  AuthRepo authRepo,
) {
  final appMiddleware = <Middleware<AppState>>[];
  appMiddleware.addAll(SignInMiddleware(authRepo).getMiddleware());
  appMiddleware.addAll(SignUpMiddleware(authRepo).getMiddleware());
  appMiddleware.addAll(HomeMiddleware(authRepo).getMiddleware());
  appMiddleware.addAll(ItemDetailsMiddleware(authRepo).getMiddleware());
  return appMiddleware;
}
