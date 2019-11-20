class ResetState {}

class UpdateItem {
  final String id;
  final String firstName;

  UpdateItem(
    this.id,
    this.firstName,
  );
}

class ShowResult {}

class ShowError {
  final Object error;

  ShowError(this.error);
}
