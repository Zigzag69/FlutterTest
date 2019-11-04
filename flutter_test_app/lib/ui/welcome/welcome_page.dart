import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/img_plane_bg.png',
               width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
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
                  return Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 44),
                            child: Text(
                              "Welcome to Flutter Test App",
                              style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: SizedBox(
                                height: 44,
                                child: RaisedButton(
                                  color: Color(0xffe1594b),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(22.0),
                                  ),
                                  child: Text(
                                    'Войти',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.sign_in_page
                                    );
                                  },
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: SizedBox(
                                height: 44,
                                child: RaisedButton(
                                  color: Color(0xff5eab9f),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(22.0),
                                      side: BorderSide(color: Colors.white)),
                                  child: Text(
                                    'Регистрация',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                              )),
                        ],
                      ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
