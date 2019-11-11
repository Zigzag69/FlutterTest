import 'package:flutter/material.dart';
import 'package:flutter_test_app/common/validator/validator.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';
import 'package:flutter_test_app/ui/sign_in/sign_in_vm.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _onInit(Store<AppState> store) {
    if (store.state.signInPageState.isDefault()) return;
    store.dispatch(ResetState());
  }

  _onDispose(Store<AppState> store) {
    if (store.state.signInPageState.isDefault()) return;
    store.dispatch(ResetState());
  }

  _onWillChange(SignInPageViewModel vm) {
    if (vm.isDefault) return;
    if (vm.email == '') return;
    if (vm.password == '') return;
    vm.resetState();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home_page,
      (Route<dynamic> route) => false,
    );
  }

  _onDidChange(SignInPageViewModel vm) {
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

  _goBack() {
    Navigator.of(context).pop();
  }

  _validateFields(SignInPageViewModel vm) {
    bool validated = true;
    String email = _emailController.text;
    String password = _passwordController.text;
    if (Validator.isEmpty(email)) {
      setState(() => _emailError = 'Email can’t be empty.');
      validated = false;
    }
    if (!Validator.isEmpty(email) && !Validator.isEmailCorrect(email)) {
      setState(() => _emailError = 'Incorrect email format.');
      validated = false;
    }

    if (Validator.isEmpty(password)) {
      setState(() => _passwordError = 'Password can’t be empty.');
      validated = false;
    }

    if (password.length < 6) {
      setState(
          () => _passwordError = 'Password must be at least 6 symbols long');
      validated = false;
    }

    if (!Validator.isEmpty(password) &&
        !Validator.isPasswordCorrect(password) &&
        password.length >= 6) {
      setState(() => _passwordError = 'Incorrect password format.');
      validated = false;
    }

    if (!validated) return;
    vm.signIn(_emailController.text, _passwordController.text);
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
              return vm.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(24, 134, 24, 0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                          borderSide: BorderSide(
                                              color: Color(0xff995eab9f)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff995eab9f),
                                              width: 2),
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
                                        LengthLimitingTextInputFormatter(30),
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
                                          borderSide: BorderSide(
                                              color: Color(0xff995eab9f)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff995eab9f),
                                              width: 2),
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                                    new BorderRadius.circular(
                                                        22.0),
                                                side: BorderSide(
                                                    color: Colors.white)),
                                            child: Text(
                                              'Войти',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              _validateFields(vm);
                                            },
                                          ),
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          AppRoutes.sign_up_page,
                                        );
                                      },
                                      child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 24),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Нет Аккаунта ?",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff5eab9f),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    )
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
