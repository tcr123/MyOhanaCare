import 'package:flutter/material.dart';
import 'package:ohana_care/constant.dart';
import 'package:ohana_care/model/event.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/calendar_provider.dart';
class EventPush extends StatefulWidget {
  const EventPush({super.key});

  @override
  State<EventPush> createState() => _EventPushState();
}

class _EventPushState extends State<EventPush> {
  DateTime now = DateTime.now().toLocal();

  late TextEditingController _eventNameController;
  late TextEditingController _eventLocationController;
  late TextEditingController _eventDateController;
  late TextEditingController _eventStartTimeController;
  late TextEditingController _eventEndTimeController;

  String _eventDate = "";
  String _eventStartTime = "";
  String _eventEndTime = "";

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
    _eventNameController = TextEditingController();
    _eventLocationController = TextEditingController();
    _eventDateController = TextEditingController();
    _eventStartTimeController = TextEditingController();
    _eventEndTimeController = TextEditingController();
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
                  const Text('Event', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                      const Text('Event Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _eventNameController,
                        decoration: const InputDecoration(
                          hintText: "General Meeting",
                          prefixIcon: Icon(Icons.event),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Event name cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Event Location', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _eventLocationController,
                        decoration: const InputDecoration(
                          hintText: "Kuala Lumpur",
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Location cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Event Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _eventDateController,
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
                                  _eventDate = formatDate(date,[yyyy, '-', mm, '-', dd]);
                                });
                                _eventDateController.text = _eventDate;
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
                            return "Event date cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Start Time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _eventStartTimeController,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                  
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DatePicker.showTime12hPicker(context, showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                _eventStartTime = formatDate(date,[hh, ':', nn, am]);
                                _eventStartTimeController.text = _eventStartTime;
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
                      const SizedBox(height: 20),
                      const Text('End Time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _eventEndTimeController,
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                  
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          FocusScope.of(context).requestFocus(new FocusNode());
                          DatePicker.showTime12hPicker(context, showTitleActions: true,
                            onConfirm: (date) {
                              setState(() {
                                _eventEndTime = formatDate(date,[hh, ':', nn, am]);
                                _eventEndTimeController.text = _eventEndTime;
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
                            return "End time cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kYellowBackground,
                            disabledBackgroundColor: kYellowBackground,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                          ),
                          onPressed: _formKey.currentState == null || !_formKey.currentState!.validate() ? null : () {
                            FocusScope.of(context).unfocus();

                            EventData eventData = EventData(
                              role:  authProvider.getUserData.role,
                              eventName: _eventNameController.text, 
                              startDate: "$_eventDate ${calendarProvider.convertDateToISO(_eventStartTime)}", 
                              endDate: "$_eventDate ${calendarProvider.convertDateToISO(_eventEndTime)}",
                              location: _eventLocationController.text
                            );

                            calendarProvider.postEvent(eventData, authProvider.getUserData.id).then((value) {
                              Navigator.pop(context, 'success');
                            });
                          },
                          child: const Text("Save",style: TextStyle(color: Colors.white),),
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
