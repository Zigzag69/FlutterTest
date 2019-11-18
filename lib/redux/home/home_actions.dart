import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test_app/data/models/user.dart';

class ResetState {}

class RemoveItem {
  final DocumentSnapshot document;

  RemoveItem(this.document);
}

class CreateUsers {}

class GetUsers {}

class ShowResult {}

class ShowUsersAction {
  List<User> usersList;

  ShowUsersAction(this.usersList);
}

class ShowError {
  final Object error;

  ShowError(this.error);
}
