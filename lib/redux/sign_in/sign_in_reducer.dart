import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_state.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_actions.dart';

Reducer<SignInPageState> signInPageReducer = combineReducers<SignInPageState>([
  TypedReducer<SignInPageState, SignIn>(_signIn),
  TypedReducer<SignInPageState, ShowResult>(_showResult),
  TypedReducer<SignInPageState, ShowError>(_showError),
  TypedReducer<SignInPageState, ResetState>(_resetState),
]);

SignInPageState _signIn(SignInPageState state, SignIn action) {
  return state.copyWith(
    isLoading: true,
    email: '',
    password: '',
    error: '',
  );
}

SignInPageState _showResult(SignInPageState state, ShowResult action) {
  return state.copyWith(
    isLoading: false,
    email: action.email,
    password: action.password
  );
}

SignInPageState _showError(SignInPageState state, ShowError action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

SignInPageState _resetState(SignInPageState state, ResetState action) {
  return SignInPageState.initial();
}