import 'package:flutter/material.dart';
import 'package:ohana_care/constant.dart';
import 'package:ohana_care/model/symptoms_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/calendar_provider.dart';
class Symptoms extends StatefulWidget {
  const Symptoms ({super.key});

  @override
  State<Symptoms> createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms > {
  DateTime now = DateTime.now().toLocal();

  late TextEditingController _symptomsDetailController;
  late TextEditingController _symptomsDateController;
  late TextEditingController _symptomsStartTimeController;

  String _symptomsDate = "";
  String _symptomsStartTime = "";

  final _formKey = GlobalKey<FormState>();

  var weekdays = [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
  ];
  var weekmonths = [
    'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov'
  ];

  @override
  void initState() {
    super.initState();
    _symptomsDetailController = TextEditingController();
    _symptomsDateController = TextEditingController();
    _symptomsStartTimeController = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final calendarProvider = Provider.of<CalendarProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kYellowBackground,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image(
            image: authProvider.getUserData.role == "Husband" 
              ? const AssetImage('assets/male_stitch.png') 
              : const AssetImage('assets/female_stitch.png'),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Text(
                '${now.day}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 36
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weekdays[now.weekday % 7],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                  ),
                  Text(
                    '${weekmonths[now.month % 12]} ${now.year}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(onPressed: () { Navigator.pop(context); }, icon: const Icon(Icons.close)),
                  const SizedBox(width: 10),
                  const Text('Symptoms', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Symptoms Detail', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _symptomsDetailController,
                        decoration: const InputDecoration(
                          hintText: "Cough",
                          prefixIcon: Icon(Icons.sick),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Symptoms cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Symptoms Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _symptomsDateController,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                  
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              onChanged: (date) {
                              }, onConfirm: (date) {
                                setState(() {
                                  _symptomsDate= formatDate(date,[yyyy, '-', mm, '-', dd]);
                                });
                                _symptomsDateController.text = _symptomsDate;
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        decoration: const InputDecoration(
                          hintText: "13/12/2022",
                          prefixIcon: Icon(Icons.date_range),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Symptoms date cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Start Time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _symptomsStartTimeController,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                  
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DatePicker.showTime12hPicker(context, showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                _symptomsStartTime = formatDate(date,[hh, ':', nn, am]);
                                _symptomsStartTimeController.text = _symptomsStartTime;
                              });
                            }, 
                            currentTime: DateTime.now()
                          );
                        },
                        decoration: const InputDecoration(
                          hintText: "10:00AM",
                          prefixIcon: Icon(Icons.timer),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Start time cannot be empty";
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kYellowBackground,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                          ),
                          onPressed: _formKey.currentState == null || !_formKey.currentState!.validate() ? null : () {
                            FocusScope.of(context).unfocus();
                            
                            SymptomsData symptomsData = SymptomsData(
                              symptomsDetail: _symptomsDetailController.text, 
                              symptomsDate: "$_symptomsDate ${calendarProvider.convertDateToISO(_symptomsStartTime)}"
                            );
                            calendarProvider.postSymptoms(symptomsData, authProvider.getUserData.id).then((value) {
                              Navigator.pop(context, 'success'); 
                            });
                          },
                          child: const Text("Save"),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
