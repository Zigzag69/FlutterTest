import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ItemDetailsState extends Equatable {
  final bool isLoading;
  final Object error;
  final String result;
  ItemDetailsState({
    this.isLoading,
    this.error,
    this.result,
  }) : super([
          isLoading,
          error,
          result,
        ]);

  factory ItemDetailsState.initial() {
    return ItemDetailsState(
      isLoading: false,
      error: '',
      result: '',
    );
  }

  ItemDetailsState copyWith({
    bool isLoading,
    Object error,
    String result,
  }) {
    return ItemDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }

  bool isDefault() {
    return isLoading == false &&
        error == '' &&
        result == '';
  }
}
