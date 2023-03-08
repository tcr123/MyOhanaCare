import 'package:flutter/material.dart';
import 'package:ohana_care/constant.dart';
import 'package:ohana_care/model/period_data.dart';
import 'package:ohana_care/model/pregnancy_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/calendar_provider.dart';
class Period extends StatefulWidget {
  const Period({super.key});

  @override
  State<Period> createState() => _PeriodState();
}

class _PeriodState extends State<Period> {
  DateTime now = DateTime.now().toLocal();
  late TextEditingController _startDayPeriodController;
  String _startDayPeriod = "";
  late TextEditingController _lastDayPeriodController;
  String _lastDayPeriod = "";
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
    _startDayPeriodController = TextEditingController();
    _lastDayPeriodController = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final calendarProvider = Provider.of<CalendarProvider>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRed,
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
                  const Text('Period', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                      const Text('First Day of Period', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _startDayPeriodController,
                        onTap: (){
                          FocusScopeNode currentFocus = FocusScope.of(context);
                  
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // DatePicker.showTimePicker(context, showTitleActions: true,
                          //     onChanged: (date) {
                          //   print('change $date in time zone ' +
                          //       date.timeZoneOffset.inHours.toString());
                          // }, onConfirm: (date) {
                          //   print('confirm $date');
                          // }, currentTime: DateTime.now());
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              onChanged: (date) {
                              }, onConfirm: (date) {
                                setState(() {
                                  _startDayPeriod = formatDate(date,[yyyy, '-', mm, '-', dd]);
                                });
                                _startDayPeriodController.text = _startDayPeriod;
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        decoration: const InputDecoration(
                          hintText: "13/12/2022",
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Start day period cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Last Day of Period', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _lastDayPeriodController,
                        onTap: (){
                          FocusScopeNode currentFocus = FocusScope.of(context);
                  
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          FocusScope.of(context).requestFocus(new FocusNode());
                          // DatePicker.showTimePicker(context, showTitleActions: true,
                          //     onChanged: (date) {
                          //   print('change $date in time zone ' +
                          //       date.timeZoneOffset.inHours.toString());
                          // }, onConfirm: (date) {
                          //   print('confirm $date');
                          // }, currentTime: DateTime.now());
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              onChanged: (date) {
                              }, onConfirm: (date) {
                                setState(() {
                                  _lastDayPeriod = formatDate(date,[yyyy, '-', mm, '-', dd]);
                                });
                                _lastDayPeriodController.text = _lastDayPeriod;
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        decoration: const InputDecoration(
                          hintText: "02/10/2022",
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Last day period cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kRed,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                          ),
                          onPressed: _formKey.currentState == null || !_formKey.currentState!.validate() ? null : () {
                            FocusScope.of(context).unfocus();

                            PeriodData periodData = PeriodData(startDayPeriod: _startDayPeriod, endDayPeriod: _lastDayPeriod);
                            calendarProvider.postPeriod(periodData, authProvider.getUserData.id).then((value) {
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
