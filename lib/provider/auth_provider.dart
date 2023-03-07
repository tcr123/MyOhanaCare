import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ohana_care/model/sign_up_data.dart';

import 'package:ohana_care/model/user.dart';

class AuthProvider extends ChangeNotifier {
  late User user;

  User get getUserData {
    return user;
  }

  User get userData => getUserData;

  Future<User?> connectYourSpouse(String email, String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/link');
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'email': email
        }));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if(jsonResponse['message']=="200 success"){
        return User(
          id: jsonResponse['spouse']['id'],
          email: jsonResponse['spouse']['email'],
          name: jsonResponse['spouse']['name'], 
          role: jsonResponse['spouse']['role'], 
          age: jsonResponse['spouse']['age'], 
          married: jsonResponse['spouse']['married'], 
          children: jsonResponse['spouse']['children'], 
          menstrual: jsonResponse['spouse']['menstrual']
        );
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return null;
      } 
      else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<String> signInHandler(String email, String password) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/auth');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': password,
            'auth': 'login',
          }));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if(jsonResponse['message']=="200 success") {
        user = User(
          id: jsonResponse['token'], 
          email: jsonResponse['user']['email'],
          name: jsonResponse['user']['name'], 
          role: jsonResponse['user']['role'], 
          age: jsonResponse['user']['age'], 
          married: jsonResponse['user']['married'], 
          children: jsonResponse['user']['children'], 
          menstrual: jsonResponse['user']['menstrual']
        );

        notifyListeners();

        return "200 success";
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return "403 invalid";
      } 
      else {
        return "404 not found";
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> signUpHandler(SignUpData signUpUser) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/auth');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': signUpUser.email,
            'password': signUpUser.password,
            'role': signUpUser.role,
            'married': signUpUser.married,
            'children': signUpUser.children,
            'menstrual': signUpUser.menstrual,
            'auth': 'signup',
            'name': signUpUser.name,
            'age': signUpUser.age
          }));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if(jsonResponse['message']=="200 success"){
        user = User(
          id: jsonResponse["token"], 
          email: signUpUser.email,
          name: signUpUser.name, 
          role: signUpUser.role, 
          age: signUpUser.age, 
          married: signUpUser.married, 
          children: signUpUser.children, 
          menstrual: signUpUser.menstrual
        );

        notifyListeners();

        return "200 success";
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return "403 invalid";
      } 
      else {
        return "404 not found";
      }
    } catch (error) {
      return error.toString();
    }
  }
}