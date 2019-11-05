import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/ui/home/home_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onInit(Store<AppState> store) {}

  _onDispose(Store<AppState> store) {}

  _onWillChange(HomePageViewModel vm) {}

  _onDidChange(HomePageViewModel vm) {}

  _logOut() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.welcome_page,
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/img_plane_bg.png',
                width: MediaQuery.of(context).size.width,
                height: 234,
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
            converter: HomePageViewModel.fromStore,
            onInit: _onInit,
            onDispose: _onDispose,
            onWillChange: _onWillChange,
            onDidChange: _onDidChange,
            builder: (BuildContext context, HomePageViewModel vm) {
              return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24, 134, 24, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Home Page",
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Color(0xff5eab9f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: SizedBox(
                                    height: 44,
                                    child: RaisedButton(
                                      color: Color(0xffe1594b),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(22.0),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      child: Text(
                                        'Log Out',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        _logOut();
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
