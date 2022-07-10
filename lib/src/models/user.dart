import 'dart:convert';

import 'package:proyectofiberpluss/src/models/Rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String? id; //NULL SAFETY
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? plan;
  String? precio;
  String? sessionToken;
  List<Rol>? roles = [];

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.plan,
    this.precio,
    this.sessionToken,
    this.roles
  });


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    image: json["image"],
    password: json["password"],
    plan: json["plan"],
    precio: json["precio"],
    sessionToken: json["session_token"],
    roles: json["roles"] == null ? [] : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))),
  );

  static List<User> fromJsonList(List<dynamic> jsonList) {
    List<User> toList = [];

    jsonList.forEach((item) {
      User users = User.fromJson(item);
      toList.add(users);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
    "plan": plan,
    "precio": precio,
    "session_token": sessionToken,
    'roles': roles
  };
}
