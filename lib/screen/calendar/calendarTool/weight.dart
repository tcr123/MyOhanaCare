import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohana_care/constant.dart';
import 'package:ohana_care/model/weight_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/calendar_provider.dart';
class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  DateTime now = DateTime.now().toLocal();
  late TextEditingController _weightController;
  late TextEditingController _weightDateController;
  String _weightDate = "";
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
    _weightController = TextEditingController();
    _weightDateController = TextEditingController();
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
                  const Text('Weight', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
                      const Text('Weight (kg)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                          hintText: "62.22",
                          prefixIcon: Icon(Icons.monitor_weight),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}'))
                        ],
                        validator: (value){
                          if (value == "" || value == null) {
                            return "Weight cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _weightDateController,
                        onTap: (){
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
                                  _weightDate = formatDate(date,[yyyy, '-', mm, '-', dd]);
                                });
                                _weightDateController.text = _weightDate;
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
                            return "Date cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.3),
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

                            WeightData weightData = WeightData(
                              weight: double.parse(_weightController.text), 
                              start: _weightDate
                            );
                            calendarProvider.postWeight(weightData, authProvider.getUserData.id).then((value) {
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
