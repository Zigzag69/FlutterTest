import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';
import 'package:flutter_test_app/ui/sign_in/sign_in_vm.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  _onInit(Store<AppState> store) {}

  _onDispose(Store<AppState> store) {}

  _onWillChange(SignInPageViewModel vm) {}

  _onDidChange(SignInPageViewModel vm) {}

  _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Color(0xff5eab9f),
            child: Align(
              alignment: Alignment.topCenter,
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: _goBack,
            ),
          ),
          body: StoreConnector(
            distinct: true,
            converter: SignInPageViewModel.fromStore,
            onInit: _onInit,
            onDispose: _onDispose,
            onWillChange: _onWillChange,
            onDidChange: _onDidChange,
            builder: (BuildContext context, SignInPageViewModel vm) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 190),
//                            child: Text(
//                              "Вход",
//                              style: TextStyle(
//                                  fontSize: 26,
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.bold),
//                            ),
                          ),
//                          Padding(
//                              padding: const EdgeInsets.only(top: 32),
//                              child: SizedBox(
//                                height: 44,
//                                child: RaisedButton(
//                                  color: Color(0xffe1594b),
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius:
//                                        new BorderRadius.circular(22.0),
//                                  ),
//                                  child: Text(
//                                    'Войти',
//                                    style: TextStyle(
//                                      fontSize: 16,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                                  onPressed: () {
//                                    print("Войти");
//                                  },
//                                ),
//                              )),
//                          Padding(
//                              padding: const EdgeInsets.only(top: 32),
//                              child: SizedBox(
//                                height: 44,
//                                child: RaisedButton(
//                                  color: Color(0xff5eab9f),
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius:
//                                          new BorderRadius.circular(22.0),
//                                      side: BorderSide(color: Colors.white)),
//                                  child: Text(
//                                    'Регистрация',
//                                    style: TextStyle(
//                                      fontSize: 16,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                                  onPressed: () {
//                                    print("Регистрация");
//                                  },
//                                ),
//                              )),
                        ],
                      )
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
