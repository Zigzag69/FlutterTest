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
  String _emailError;
  TextEditingController _emailController;
  String _passwordError;
  TextEditingController _passwordController;
  double topPaddingText;
  FocusNode _passwordFocusNode;
  FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }

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
            color: Colors.white,
            child: Align(
              alignment: Alignment.topCenter,
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
//          resizeToAvoidBottomPadding: false,
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
                                      "Вход",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Color(0xff5eab9f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              SizedBox(height: 22),
                              TextField(
                                focusNode: _emailFocusNode,
                                onSubmitted: (email) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                                textInputAction: TextInputAction.next,
                                cursorColor: Color(0xff979797),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xff7acfc2),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff995eab9f)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff995eab9f), width: 2),
                                  ),
                                  errorText: _emailError,
                                  errorMaxLines: 1,
                                  errorStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.red,
                                  ),
                                ),
                                onChanged: (phone) {
                                  setState(() => _emailError = null);
                                },
                                keyboardType: TextInputType.emailAddress,
                                maxLines: 1,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(256),
                                ],
                                autocorrect: false,
                                controller: _emailController,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color(0xff484848),
                                ),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              TextField(
                                focusNode: _passwordFocusNode,
                                textInputAction: TextInputAction.done,
                                cursorColor: Color(0xff979797),
                                decoration: InputDecoration(
                                  labelText: 'Пароль',
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xff7acfc2),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff995eab9f)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff995eab9f), width: 2),
                                  ),
                                  errorText: _passwordError,
                                  errorMaxLines: 1,
                                  errorStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.red,
                                  ),
                                ),
                                onChanged: (phone) {
                                  setState(() => _passwordError = null);
                                },
                                keyboardType: TextInputType.visiblePassword,
                                maxLines: 1,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                ],
                                autocorrect: false,
                                controller: _passwordController,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Color(0xff484848),
                                ),
                              ),
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
                                        'Войти',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Нет Аккаунта ?",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff5eab9f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
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
