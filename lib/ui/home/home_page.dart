import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/ui/home/home_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _skills = new List();
  List skillsData = [
    "Name",
    "Surname",
    "Years",
  ];
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _addSkills();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _addSkills() {
    for (var i = 0; i < skillsData.length; i++) {
      _skills.add(skillsData[i]);
    }
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

  Widget _listView(context, snapshot) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (BuildContext context, int index) {
          return new Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: 60,
                      width: (MediaQuery.of(context).size.width - 116) / 2 - 5,
                      color: Color(0xFF31373c),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            _skills[index],
                            style: TextStyle(
                              color: Color(0xFFfffff8),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("tap item 1");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      child: Container(
                        height: 60,
                        width:
                            (MediaQuery.of(context).size.width - 116) / 2 - 5,
                        color: Color(0xFF31373c),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
//                              snapshot.data.documents[index],
                            "2",
                              style: TextStyle(
                                color: Color(0xFFfffff8),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        print("tap item 2");
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ));
        });
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
              return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: StreamBuilder(
                                  stream: Firestore.instance
                                      .collection('testItems')
                                      .snapshots(),
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
                                    return _listView(context, snapshot);
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
