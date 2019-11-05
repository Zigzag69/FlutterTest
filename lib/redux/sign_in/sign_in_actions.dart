class ResetState {}

class SignIn {
  final String email;
  final String password;

  SignIn(this.email, this.password);
}

class ShowResult {
  final String email;
  final String password;

  ShowResult(this.email, this.password);
}

class ShowError {
  final Object error;

  ShowError(this.error);
}