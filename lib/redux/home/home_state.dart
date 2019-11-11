import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class HomePageState extends Equatable {
  final bool isLoading;
  final Object error;
  HomePageState({
    this.isLoading,
    this.error,
  }) : super([
          isLoading,
          error,
        ]);

  factory HomePageState.initial() {
    return HomePageState(
      isLoading: false,
      error: '',
    );
  }

  HomePageState copyWith({
    bool isLoading,
    Object error,
  }) {
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool isDefault() {
    return isLoading == false && error == '';
  }
}
