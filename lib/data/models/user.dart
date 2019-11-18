import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
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

  @override
  String toString() {
    return 'User[firstName: $firstName, lastName: $lastName, age: $age]';
  }
}