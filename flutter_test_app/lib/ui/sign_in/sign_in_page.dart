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
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
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
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 190 - AppBar().preferredSize.height),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Вход",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xff5eab9f),
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          SizedBox(height: 8),
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
                              letterSpacing: 1.2,
                              fontFamily: 'poppins_medium',
                              fontSize: 24,
                              color: Color(0xff484848),
                            ),
                          ),
//                          TextField(
//                            focusNode: _passwordFocusNode,
//                            textInputAction: TextInputAction.done,
//                            cursorColor: Color(0xff979797),
//                            decoration: InputDecoration(
//                              labelText: 'Email',
//                              labelStyle: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 18,
//                                color: Color(0xff7acfc2),
//                              ),
//                              enabledBorder: UnderlineInputBorder(
//                                borderSide:
//                                    BorderSide(color: Color(0xff995eab9f)),
//                              ),
//                              focusedBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(
//                                    color: Color(0xff995eab9f), width: 2),
//                              ),
//                              errorText: _emailError,
//                              errorMaxLines: 1,
//                              errorStyle: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 10,
//                                color: Colors.red,
//                              ),
//                            ),
//                            onChanged: (phone) {
//                              setState(() => _emailError = null);
//                            },
//                            keyboardType: TextInputType.emailAddress,
//                            maxLines: 1,
//                            inputFormatters: [
//                              LengthLimitingTextInputFormatter(256),
//                            ],
//                            autocorrect: false,
//                            controller: _emailController,
//                            style: TextStyle(
//                              letterSpacing: 1.2,
//                              fontFamily: 'poppins_medium',
//                              fontSize: 24,
//                              color: Color(0xff484848),
//                            ),
//                          ),
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
