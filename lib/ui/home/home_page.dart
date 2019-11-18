import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:flutter_test_app/ui/item_details/item_details_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/ui/home/home_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

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

  _onInit(Store<AppState> store) {
    store.dispatch(GetUsers());
  }

  _onDispose(Store<AppState> store) {
    if (store.state.signInPageState.isDefault()) return;
    store.dispatch(ResetState());
  }

  _onWillChange(HomePageViewModel vm) {
    if (vm.isDefault) return;
    vm.resetState();
  }

  _onDidChange(HomePageViewModel vm) {
    if (vm.isDefault) return;
    if (vm.error == '') return;
    vm.resetState();
    String message;
    if (vm.error is PlatformException) {
      PlatformException pe = vm.error;
      message = pe.message;
    } else {
      message = vm.error.toString();
    }
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 10,
            color: Color(0xff5eab9f),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _logOut() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.welcome_page,
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildListView(
    HomePageViewModel vm,
    BuildContext context,
    DocumentSnapshot document,
    index,
  ) {
    return new Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 60,
                width: (MediaQuery.of(context).size.width - 116) / 3 - 5,
                color: Color(0xFF31373c),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      document['firstName'],
                      style: TextStyle(
                        color: Color(0xFFfffff8),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                vm.getUsers();
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                child: Container(
                  height: 60,
                  width: (MediaQuery.of(context).size.width - 116) / 3 - 5,
                  color: Color(0xFF31373c),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        document['lastName'],
                        style: TextStyle(
                          color: Color(0xFFfffff8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  vm.getUsers();
//                  Navigator.of(context).pushNamed(
//                    AppRoutes.item_details,
//                    arguments: ItemDetailsArgs(document),
//                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                child: Container(
                  height: 60,
                  width: (MediaQuery.of(context).size.width - 116) / 3 - 5,
                  color: Color(0xFF31373c),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        document['age'].toString(),
                        style: TextStyle(
                          color: Color(0xFFfffff8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  vm.getUsers();
//                  Navigator.of(context).pushNamed(
//                    AppRoutes.item_details,
//                    arguments: ItemDetailsArgs(document),
//                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/ic_trash_white.svg',
                  width: 44.0,
                  height: 44.0,
                ),
                onPressed: () {
                  vm.removeItem(document);
                },
              ),
            ),
          ],
        ));
  }

  Widget _errorWidget(String errorText) {
    return Padding(
      padding: EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            errorText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'poppins_medium',
              fontSize: 16,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          RaisedButton(
            color: Color(0xffBD10E0),
            elevation: 0,
            highlightElevation: 0,
            padding: EdgeInsets.only(top: 18, bottom: 19),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            child: Text(
              'Try again',
              style: TextStyle(
                fontFamily: 'poppins_medium',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              print("tap");
            },
          ),
        ],
      ),
    );
  }

  Widget _loaderWidget() {
    return new Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildBody(HomePageViewModel vm) {
    return new Padding(
      padding: const EdgeInsets.only(top: 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 50, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Home Page",
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xff5eab9f),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                          height: 84,
                          color: Color(0xFF2a3035),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 30, right: 24, left: 24),
                            child: RaisedButton(
                              color: Color(0xffe1594b),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(22.0),
                                  side: BorderSide(color: Colors.white)),
                              child: Text(
                                'create 10 users',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                vm.createUsers();
                              },
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: StreamBuilder(
                        stream:
                            Firestore.instance.collection('users').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFfffff8),
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) => _buildListView(
                                  vm,
                                  context,
                                  snapshot.data.documents[index],
                                  index));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Color(0xFF2a3035),
            child: Align(
              alignment: Alignment.bottomCenter,
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
              return vm.loading
                  ? _loaderWidget() : _buildBody(vm);
//                  : vm.error != '' && vm.error is PlatformException ? _errorWidget("test") : _buildBody(vm);
            },
          ),
          bottomNavigationBar: Container(
              height: 84,
              color: Color(0xFF2a3035),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 30, right: 24, left: 24),
                child: RaisedButton(
                  color: Color(0xffe1594b),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(22.0),
                      side: BorderSide(color: Colors.white)),
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
        ),
      ],
    );
  }
}
