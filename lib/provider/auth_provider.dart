import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ohana_care/model/sign_up_data.dart';

class AuthProvider extends ChangeNotifier {
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

      if(jsonResponse['message']=="200 success"){
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

  Future<String> signUpHandler(SignUpData user) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/auth');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': user.email,
            'password': user.password,
            'role': user.role,
            'married': user.married,
            'children': user.children,
            'menstrual': user.menstrual,
            'auth': 'signup',
            'name': user.name,
            'age': user.age
          }));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if(jsonResponse['message']=="200 success"){
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