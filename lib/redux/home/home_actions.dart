import 'package:flutter_test_app/data/models/user.dart';

class RemoveUser {
  final String id;
  final int index;

  RemoveUser(this.id, this.index);
}

class CreateUsers {}

class GetUsers {}

class ShowResult {
  final String result;
  final String index;
  final List<User> newUsers;

  ShowResult(this.result, this.index, this.newUsers);
}

class ShowUsersAction {
  final List<User> usersList;
  final Object bError;

  ShowUsersAction(this.usersList, this.bError);
}

class ShowSError {
  final Object sError;

  ShowSError(this.sError);
}

class ClearResult {}

class ClearSError {}

class ResetState {}