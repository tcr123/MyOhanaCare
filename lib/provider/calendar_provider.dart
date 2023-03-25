import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:ohana_care/model/period_data.dart';
import 'package:ohana_care/model/pregnancy_data.dart';
import 'package:ohana_care/model/symptoms_data.dart';
import 'package:intl/intl.dart';

import '../model/event.dart';
import '../model/weight_data.dart';

class CalendarProvider extends ChangeNotifier {
  String convertDateToISO(String time) {
    DateTime date2= DateFormat("hh:mma").parse(time); 
    List<String> temp = date2.toString().split(' ');
    return temp[1];
  }

  Future<List<EventData>> fetchUserTodayEvent(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/event?today=true');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);

      List<EventData> userEvent = [];

      if(jsonResponse['message']=="200 success"){
        for (var data in jsonResponse['data']) {
          DateTime startDate = DateTime.parse(data['start']);
          DateTime endDate = DateTime.parse(data['end']);
          EventData newData = EventData(
            role: data['role'], 
            eventName: data['title'], 
            startDate: startDate.toString(), 
            endDate: endDate.toString(), 
            location: data['location']
          );
          userEvent.add(newData);
        }
        return userEvent;
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

  Future<List<EventData>> fetchUserEvent(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/event');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);

      List<EventData> userEvent = [];

      if(jsonResponse['message']=="200 success"){
        for (var data in jsonResponse['data']) {
          String start = data['start'].toString();
          String end = data['end'].toString();
          DateTime startDate = DateTime.parse(start.substring(0, start.length - 1));
          DateTime endDate = DateTime.parse(end.substring(0, end.length - 1));
          EventData newData = EventData(
            role: data['role'], 
            eventName: data['title'], 
            startDate: startDate.toString(), 
            endDate: endDate.toString(), 
            location: data['location']
          );
          userEvent.add(newData);
        }
        return userEvent;
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

  Future<void> postEvent(EventData eventData, String token) async {
    try {
      DateTime start = DateTime.parse(eventData.startDate);
      DateTime end = DateTime.parse(eventData.endDate);

      var url = Uri.parse('https://sticheapi.vercel.app/api/event');
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'role': eventData.role,
          'title': eventData.eventName,
          'start': '${start.toIso8601String()}Z',
          'end': '${end.toIso8601String()}Z',
          'location': eventData.location
        }));
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['message']=="200 success"){
        
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return;
      } 
      else {
        return;
      }
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<PregnancyData?> fetchUserPregnancy(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/user');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['message']=="200 success"){
        if (jsonResponse['data']['last_day_period'] == null || jsonResponse['data']['delivery_date'] == null) return null;
        String tempPeriod = jsonResponse['data']['last_day_period'].toString();
        String tempDeliveryDate = jsonResponse['data']['delivery_date'].toString();
        DateTime lastDayPeriod = DateTime.parse(tempPeriod.toString().substring(0,tempPeriod.length - 1));
        DateTime expectedDeliveryDate = DateTime.parse(tempDeliveryDate.toString().substring(0, tempDeliveryDate.length - 1));
        PregnancyData userPregnancyData = PregnancyData(
          lastDayPeriod: lastDayPeriod.toString().split(' ')[0], 
          expectedDeliveryDate: expectedDeliveryDate.toString().split(' ')[0]
        );
        return userPregnancyData;
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return null;
      } 
      else {
        return null;
      }
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> postPregnancyCalculation(PregnancyData pregnancyData, String token) async {
    try {
      DateTime lastDayPeriod = DateTime.parse(pregnancyData.lastDayPeriod);
      DateTime expectedDeliveryDate = DateTime.parse(pregnancyData.expectedDeliveryDate);

      var url = Uri.parse('https://sticheapi.vercel.app/api/user');
      var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'last_day_period': '${lastDayPeriod.toIso8601String()}Z',
          'delivery_date': '${expectedDeliveryDate.toIso8601String()}Z'
        }));
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['message']=="200 success"){
        
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return;
      } 
      else {
        return;
      }
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<List<PeriodData>> fetchUserPeriod(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/period');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);

      List<PeriodData> userPeriod = [];

      if(jsonResponse['message']=="200 success"){
        for (var data in jsonResponse['data']) {
          DateTime startDate = DateTime.parse(data['start']);
          DateTime endDate = DateTime.parse(data['end']);
          PeriodData newData = PeriodData(startDayPeriod: startDate.toString().split(' ')[0], endDayPeriod: endDate.toString().split(' ')[0]);
          userPeriod.add(newData);
        }
        return userPeriod;
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

  Future<void> postPeriod(PeriodData period, String token) async {
    try {
      DateTime startDayPeriod = DateTime.parse(period.startDayPeriod);
      DateTime endDayPeriod = DateTime.parse(period.endDayPeriod);

      var url = Uri.parse('https://sticheapi.vercel.app/api/period');
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'start': '${startDayPeriod.toIso8601String()}Z',
          'end': '${endDayPeriod.toIso8601String()}Z'
        }));
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['message']=="200 success"){
        
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return;
      } 
      else {
        return;
      }
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<List<WeightData>> fetchUserWeight(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/weight');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);

      List<WeightData> userWeight = [];

      if(jsonResponse['message']=="200 success"){
        for (var data in jsonResponse['data']) {
          DateTime date = DateTime.parse(data['start']);
          WeightData newData = WeightData(weight: double.parse(data['weight'].toString()), start: date.toString().split(' ')[0]);
          userWeight.add(newData);
        }
        return userWeight;
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

  Future<void> postWeight(WeightData weight, String token) async {
    try {
      DateTime weightDate = DateTime.parse(weight.start);

      var url = Uri.parse('https://sticheapi.vercel.app/api/weight');
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'weight': weight.weight,
          'start': '${weightDate.toIso8601String()}Z'
        }));
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['message']=="200 success"){
        
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return;
      } 
      else {
        return;
      }
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<List<SymptomsData>> fetchUserSymptoms(String token) async {
    try {
      var url = Uri.parse('https://sticheapi.vercel.app/api/symptom');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      var jsonResponse = jsonDecode(response.body);

      List<SymptomsData> fetchUserSymptoms = [];

      if(jsonResponse['message']=="200 success"){
        for (var data in jsonResponse['data']) {
          DateTime date = DateTime.parse(data['start']);
          SymptomsData newData = SymptomsData(symptomsDetail: data['title'], symptomsDate: data['start']);
          fetchUserSymptoms.add(newData);
        }
        return fetchUserSymptoms;
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

  Future<void> postSymptoms(SymptomsData symptoms, String token) async {
    try {
      DateTime symptomsDate = DateTime.parse(symptoms.symptomsDate);

      var url = Uri.parse('https://sticheapi.vercel.app/api/symptom');
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          'title': symptoms.symptomsDetail,
          'start': '${symptomsDate.toIso8601String()}Z'
        }));
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['message']=="200 success"){
        
      }
      else if (jsonResponse["message"] == "403 invalid") {
        return;
      } 
      else {
        return;
      }
    } catch (error) {
      print(error);
      return;
    }
  }
}