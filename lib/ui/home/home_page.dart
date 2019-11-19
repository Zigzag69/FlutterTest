import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/ui/item_details/item_details_page.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';
import 'package:flutter_test_app/ui/home/home_vm.dart';

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

  _onInit(Store<AppState> store) {
    store.dispatch(GetUsers());
  }

  _onDispose(Store<AppState> store) {
    if (store.state.homePageState.isDefault()) return;
    store.dispatch(ResetState());
  }

  _onDidChange(HomePageViewModel vm) {
    if (vm.isDefault) return;
    if (vm.sError == '') return;
    vm.clearSError();
    String message;
    if (vm.sError is PlatformException) {
      PlatformException pe = vm.sError;
      message = pe.message;
    } else {
      message = vm.sError.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF2a3035),
      body: StoreConnector(
        distinct: true,
        converter: HomePageViewModel.fromStore,
        onInit: _onInit,
        onDispose: _onDispose,
        onDidChange: _onDidChange,
        builder: (BuildContext context, HomePageViewModel vm) {
          return vm.loading
              ? LoaderWidget()
              : vm.bError != '' ? _errorWidget(vm) : _buildBody(vm);
        },
      ),
    );
  }

  Widget _buildBody(HomePageViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTitle(),
        _buildButtonCreateUsers(),
        Expanded(
          child: ListView.builder(
            itemCount: vm.users.length,
            itemBuilder: (context, index) {
              return _buildListView(
                vm,
                context,
                index,
              );
            },
          ),
        ),
        _buildButtonLogOut(),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: Text(
          "Home Page",
          style: TextStyle(
            fontSize: 40,
            color: Color(0xff5eab9f),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCreateUsers() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
          height: 84,
          color: Color(0xFF2a3035),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, right: 24, left: 24),
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
                print("create 10 users");
              },
            ),
          )),
    );
  }

  Widget _buildListView(
    HomePageViewModel vm,
    BuildContext context,
    index,
  ) {
    return new Padding(
        padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
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
                      vm.users[index].firstName.toString(),
                      style: TextStyle(
                        color: Color(0xFFfffff8),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
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
                        vm.users[index].lastName.toString(),
                        style: TextStyle(
                          color: Color(0xFFfffff8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {},
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
                        vm.users[index].age.toString(),
                        style: TextStyle(
                          color: Color(0xFFfffff8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.item_details,
//                      arguments: ItemDetailsArgs(),
                  );
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
//                  vm.removeItem(vm.users[index]);
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildButtonLogOut() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          height: 84,
          color: Color(0xFF2a3035),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 30, right: 24, left: 24),
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
    );
  }

  Widget _errorWidget(HomePageViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            vm.bError,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'poppins_medium',
              fontSize: 16,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          Container(
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
                    'Try again',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    vm.getUsers();
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
