import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ItemDetailsState extends Equatable {
  ItemDetailsState() : super([]);

  factory ItemDetailsState.initial() {
    return ItemDetailsState();
  }

  ItemDetailsState copyWith() {
    return ItemDetailsState();
  }
}