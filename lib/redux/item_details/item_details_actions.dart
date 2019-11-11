import 'package:cloud_firestore/cloud_firestore.dart';

class ResetState {}

class UpdateItem {
  final DocumentSnapshot document;
  final String newName;

  UpdateItem(
    this.document,
    this.newName,
  );
}

class ShowResult {}

class ShowError {
  final Object error;

  ShowError(this.error);
}
