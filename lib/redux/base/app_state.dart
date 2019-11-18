import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_app/redux/sign_in/sign_in_state.dart';
import 'package:flutter_test_app/redux/sign_up/sign_up_state.dart';
import 'package:flutter_test_app/redux/home/home_state.dart';
import 'package:flutter_test_app/redux/item_details/item_details_state.dart';

@immutable
class AppState extends Equatable {
  final SignInPageState signInPageState;
  final SignUpPageState signUpPageState;
  final HomePageState homePageState;
  final ItemDetailsState itemDetailsState;
  AppState({
    this.signInPageState,
    this.signUpPageState,
    this.homePageState,
    this.itemDetailsState,
  }) : super([
          signInPageState,
          signUpPageState,
          homePageState,
          itemDetailsState,
        ]);

  factory AppState.initial() {
    return AppState(
      signInPageState: SignInPageState.initial(),
      signUpPageState: SignUpPageState.initial(),
      homePageState: HomePageState.initial(),
      itemDetailsState: ItemDetailsState.initial(),
    );
  }

  AppState copyWith({
    SignInPageState signInPageState,
    SignUpPageState signUpPageState,
    HomePageState homePageState,
    ItemDetailsState itemDetailsState,
  }) {
    return AppState(
      signInPageState: signInPageState ?? this.signInPageState,
      signUpPageState: signUpPageState ?? this.signUpPageState,
      homePageState: homePageState ?? this.homePageState,
      itemDetailsState: itemDetailsState ?? this.itemDetailsState,
    );
  }
}
