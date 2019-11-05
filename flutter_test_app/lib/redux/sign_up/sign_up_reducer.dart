import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_actions.dart';

Reducer<SignUpPageState> signUpPageReducer = combineReducers<SignUpPageState>([
  TypedReducer<SignUpPageState, SignUp>(_signUp),
  TypedReducer<SignUpPageState, ShowResult>(_showResult),
  TypedReducer<SignUpPageState, ShowError>(_showError),
  TypedReducer<SignUpPageState, ResetState>(_resetState),
]);

SignUpPageState _signUp(SignUpPageState state, SignUp action) {
  return state.copyWith(
    isLoading: true,
    email: '',
    password: '',
    error: '',
  );
}

SignUpPageState _showResult(SignUpPageState state, ShowResult action) {
  return state.copyWith(
      isLoading: false,
      email: action.email,
      password: action.password
  );
}

SignUpPageState _showError(SignUpPageState state, ShowError action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

SignUpPageState _resetState(SignUpPageState state, ResetState action) {
  return SignUpPageState.initial();
}