import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

abstract class ListUsers {}

class User implements ListUsers {
  String firstName;
  String lastName;
  int age;

  User({
    this.firstName,
    this.lastName,
    this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json["firstName"],
      lastName: json["lastName"],
      age: json["age"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
  };
}