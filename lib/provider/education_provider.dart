import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:ohana_care/model/information.dart';
import 'package:ohana_care/model/period_data.dart';
import 'package:ohana_care/model/pregnancy_data.dart';
import 'package:ohana_care/model/symptoms_data.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';
import '../model/weight_data.dart';

class EducationProvider extends ChangeNotifier {

  

  Future<List<Information>> fetchEducation(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/education');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);
      
      List<Information> information = [];

      if(jsonResponse['message']=="200 success"){
        for (var data in jsonResponse['data']) {
          
          Information newData = Information(
            title: data['title'], 
            text: data['text'], 
            description: data['description'], 
            img: data['img'], 
            category: data['category']
          );
          information.add(newData);
          print(data['category']);
        }
        return information;
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return [];
      } 
      else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  
}