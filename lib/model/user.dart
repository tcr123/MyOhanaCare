import 'package:flutter/rendering.dart';

class User {
  String id;
  String email;
  String name;
  String role;
  int age;
  String married;
  String children;
  String menstrual;

  User ({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.age,
    required this.married,
    required this.children,
    required this.menstrual
  });
}