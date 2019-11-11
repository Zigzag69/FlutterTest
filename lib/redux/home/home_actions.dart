import 'package:cloud_firestore/cloud_firestore.dart';

class ResetState {}


class RemoveItem {
    final DocumentSnapshot document;
    final String newName;

  RemoveItem(this.document, this.newName);
}

class ShowResult {}

class ShowError {
  final Object error;

  ShowError(this.error);
}