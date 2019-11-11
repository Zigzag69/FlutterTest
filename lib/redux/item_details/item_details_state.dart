import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ItemDetailsState extends Equatable {
  final bool isLoading;
  final Object error;
  ItemDetailsState({
    this.isLoading,
    this.error,
  }) : super([
          isLoading,
          error,
        ]);

  factory ItemDetailsState.initial() {
    return ItemDetailsState(
      isLoading: false,
      error: '',
    );
  }

  ItemDetailsState copyWith({
    bool isLoading,
    Object error,
  }) {
    return ItemDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool isDefault() {
    return isLoading == false && error == '';
  }
}
