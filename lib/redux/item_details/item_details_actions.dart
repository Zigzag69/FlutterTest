class ResetState {}

class UpdateItem {
  final String id;
  final String firstName;

  UpdateItem(
    this.id,
    this.firstName,
  );
}

class ShowResult {
  final String result;

  ShowResult(this.result);
}

class ShowError {
  final Object error;

  ShowError(this.error);
}
