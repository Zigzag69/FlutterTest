import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:flutter_test_app/redux/base/app_reducer.dart';
import 'package:flutter_test_app/redux/base/app_store.dart';
import 'package:flutter_test_app/ui/home/home_page.dart';
import 'package:flutter_test_app/ui/item_details/item_details_page.dart';
import 'package:flutter_test_app/ui/sign_in/sign_in_page.dart';
import 'package:flutter_test_app/ui/sign_up/sign_up_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/ui/welcome/welcome_page.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool checkSession(SharedPreferences sharedPreferences) {
  print(sharedPreferences.containsKey('user'));
  if (sharedPreferences.containsKey('user')) return true;
  return false;
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xff26000000),
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final sp = await SharedPreferences.getInstance();
  final store = await appStore(sp);
  final isSessionAvailable = checkSession(sp);
  runApp(FlutterTestApp(store, isSessionAvailable));
}

class FlutterTestApp extends StatefulWidget {
  final Store<AppState> store;
  final bool isSessionAvailable;

  FlutterTestApp(this.store, this.isSessionAvailable);

  @override
  FlutterTestAppState createState() => FlutterTestAppState();
}

class FlutterTestAppState extends State<FlutterTestApp> {
  var _navigatorKey;

  @override
  void initState() {
    _navigatorKey = GlobalKey<NavigatorState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          home: widget.isSessionAvailable ? HomePage() : WelcomePage(),
          onGenerateRoute: (RouteSettings settings) {
            final routes = <String, WidgetBuilder>{
              AppRoutes.welcome_page: (context) => WelcomePage(),
              AppRoutes.sign_in_page: (context) => SignInPage(),
              AppRoutes.sign_up_page: (context) => SignUpPage(),
              AppRoutes.home_page: (context) => HomePage(),
              AppRoutes.item_details: (context) => ItemDetailsPage(),
            };
            final builder = routes[settings.name];
            return MaterialPageRoute(
              settings: RouteSettings(name: settings.name),
              builder: (context) => builder(context),
            );
          },
        ));
  }
}
