import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/home/home_state.dart';
import 'package:flutter_test_app/redux/home/home_actions.dart';

Reducer<HomePageState> homePageReducer = combineReducers<HomePageState>([
  TypedReducer<HomePageState, RemoveItem>(_removeItem),
  TypedReducer<HomePageState, GetUsers>(_getUsers),
  TypedReducer<HomePageState, ShowUsersAction>(_showUsers),
  TypedReducer<HomePageState, CreateUsers>(_createUsers),
  TypedReducer<HomePageState, ShowSError>(_showSError),
  TypedReducer<HomePageState, ClearSError>(_clearSError),
  TypedReducer<HomePageState, ResetState>(_resetState),
  TypedReducer<HomePageState, ShowResult>(_showResult),
]);

HomePageState _getUsers(HomePageState state, GetUsers action) {
  return state.copyWith(
    isLoading: true,
    bError: '',
  );
}

HomePageState _removeItem(HomePageState state, RemoveItem action) {
  return state.copyWith(
    isLoading: true,
    sError: '',
  );
}

HomePageState _showUsers(HomePageState state, ShowUsersAction action) {
  return state.copyWith(
    users: action.usersList,
    isLoading: false,
    bError: action.bError,
  );
}

HomePageState _createUsers(HomePageState state, CreateUsers action) {
  return state.copyWith(
    isLoading: true,
    sError: '',
  );
}

HomePageState _showResult(HomePageState state, ShowResult action) {
  return state.copyWith(
    isLoading: false,
  );
}

HomePageState _showSError(HomePageState state, ShowSError action) {
  return state.copyWith(
    isLoading: false,
    sError: action.sError,
  );
}

HomePageState _clearSError(HomePageState state, ClearSError action) {
  return state.copyWith(
    sError: '',
  );
}

HomePageState _resetState(HomePageState state, ResetState action) {
  return HomePageState.initial();
}

