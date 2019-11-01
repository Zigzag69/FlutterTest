import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/welcome/welcome_actions.dart';
import 'package:flutter_test_app/ui/welcome/welcome_vm.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  _onInit(Store<AppState> store) {}

  _onDispose(Store<AppState> store) {}

  _onWillChange(WelcomePageViewModel vm) {}

  _onDidChange(WelcomePageViewModel vm) {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Color(0xff5eab9f),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: StoreConnector(
            distinct: true,
            converter: WelcomePageViewModel.fromStore,
            onInit: _onInit,
            onDispose: _onDispose,
            onWillChange: _onWillChange,
            onDidChange: _onDidChange,
            builder: (BuildContext context, WelcomePageViewModel vm) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: constraints.maxHeight),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "WELCOME",
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      )
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}