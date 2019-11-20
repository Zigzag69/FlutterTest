import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String firstName;
  String lastName;
  int age;
  String id;

  User({
    this.firstName,
    this.lastName,
    this.age,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json["firstName"],
      lastName: json["lastName"],
      age: json["age"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "age": age,
    "id": id,
  };

  @override
  String toString() {
    return 'User[firstName: $firstName, lastName: $lastName, age: $age, id: $id]';
  }
}