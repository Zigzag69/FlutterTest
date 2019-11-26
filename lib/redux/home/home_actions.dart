import 'package:flutter_test_app/data/models/user.dart';

class RemoveUser {
  final String id;

  RemoveUser(this.id);
}

class CreateUsers {}

class GetUsers {}

class ShowResult {}

class ShowUsersAction {
  final List<User> usersList;
  final Object bError;

  ShowUsersAction(this.usersList, this.bError);
}

class ShowSError {
  final Object sError;

  ShowSError(this.sError);
}

class ClearSError {}

class ResetState {}