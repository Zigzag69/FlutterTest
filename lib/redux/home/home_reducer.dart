import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/home/home_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';

Reducer<HomePageState> homePageReducer = combineReducers<HomePageState>([
  TypedReducer<HomePageState, RemoveItem>(_removeItem),
  TypedReducer<HomePageState, GetUsers>(_getUsers),
  TypedReducer<HomePageState, ShowError>(_showError),
  TypedReducer<HomePageState, ResetState>(_resetState),
  TypedReducer<HomePageState, ShowResult>(_showResult),
]);

HomePageState _removeItem(HomePageState state, RemoveItem action) {
  return state.copyWith(
    isLoading: true,
    error: '',
  );
}

HomePageState _getUsers(HomePageState state, GetUsers action) {
  return state.copyWith(
    isLoading: true,
    error: '',
  );
}

HomePageState _showResult(HomePageState state, ShowResult action) {
  return state.copyWith(
    isLoading: false,
  );
}

HomePageState _showError(HomePageState state, ShowError action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

HomePageState _resetState(HomePageState state, ResetState action) {
  return HomePageState.initial();
}
