import 'package:flutter/rendering.dart';

class User {
  String id;
  String email;
  String password;
  String name;
  String role;
  int age;
  String married;
  String children;
  String menstrual;

  User ({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.age,
    required this.married,
    required this.children,
    required this.menstrual
  });
}