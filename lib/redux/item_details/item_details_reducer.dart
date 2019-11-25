import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';
import 'package:flutter_test_app/redux/item_details/item_details_state.dart';

Reducer<ItemDetailsState> itemDetailsReducer = combineReducers<ItemDetailsState>([
  TypedReducer<ItemDetailsState, UpdateItem>(_updateItem),
  TypedReducer<ItemDetailsState, ShowError>(_showError),
  TypedReducer<ItemDetailsState, ResetState>(_resetState),
  TypedReducer<ItemDetailsState, ShowResult>(_showResult),
]);

ItemDetailsState _updateItem(ItemDetailsState state, UpdateItem action) {
  return state.copyWith(
    isLoading: true,
    error: '',
  );
}

ItemDetailsState _showResult(ItemDetailsState state, ShowResult action) {
  return state.copyWith(
    isLoading: false,
    result: action.result,
  );
}

ItemDetailsState _showError(ItemDetailsState state, ShowError action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

ItemDetailsState _resetState(ItemDetailsState state, ResetState action) {
  return ItemDetailsState.initial();
}
