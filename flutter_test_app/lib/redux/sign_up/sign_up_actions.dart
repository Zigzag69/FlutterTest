class ResetState {}

class SignUp {
  final String email;
  final String password;

  SignUp(this.email, this.password);
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