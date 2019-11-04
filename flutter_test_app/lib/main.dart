import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:flutter_test_app/redux/base/app_reducer.dart';
import 'package:flutter_test_app/ui/sign_in/sign_in_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_app/ui/welcome/welcome_page.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';

Future<Store<AppState>> appStore() async {
  return Store(appReducer, initialState: AppState.initial());
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
  final store = await appStore();
  runApp(FlutterTestApp(store));
}

class FlutterTestApp extends StatefulWidget {
  final Store<AppState> store;

  FlutterTestApp(this.store);

  @override
  FlutterTestAppState createState() => FlutterTestAppState();
}

class FlutterTestAppState extends State<FlutterTestApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomePage(),
          onGenerateRoute: (RouteSettings settings) {
            final routes = <String, WidgetBuilder>{
              AppRoutes.sign_in_page: (context) => SignInPage(),
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
