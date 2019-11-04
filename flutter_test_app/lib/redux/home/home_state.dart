import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class HomePageState extends Equatable {
  HomePageState() : super([]);

  factory HomePageState.initial() {
    return HomePageState();
  }

  HomePageState copyWith() {
    return HomePageState();
  }
}