import 'package:cloud_firestore/cloud_firestore.dart';

class ResetState {}

class RemoveItem {
  final DocumentSnapshot document;

  RemoveItem(this.document);
}

class CreateUsers {}

class GetUsers {}

class ShowResult {}

class ShowError {
  final Object error;

  ShowError(this.error);
}
