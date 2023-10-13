import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String email;
  String name;
  int age;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          age: json['age'],
          name: json['name'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "age": age,
      "name": name,
    };
  }
}
