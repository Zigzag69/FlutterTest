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
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 11, 16, 36),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Request a game',
                                style: TextStyle(
                                  letterSpacing: 1.15,
                                  fontFamily: 'poppins_bold',
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 18),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(top: 36),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 65,
                                    width: double.infinity,
                                    child: RaisedButton(
                                      color: Color(0xFFBD10E0),
                                      splashColor: Colors.brown,
                                      elevation: 0,
                                      highlightElevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(3)),
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          fontFamily: 'poppins_medium',
                                          fontSize: 20,
                                          color: Colors.white,
                                          letterSpacing: 1.44,
                                        ),
                                      ),
                                      onPressed: () {

                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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