import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ohana_care/constant.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class editSOS extends StatefulWidget {
  const editSOS({super.key});

  @override
  State<editSOS> createState() => _editSOSState();
}

class _editSOSState extends State<editSOS> {
  late TextEditingController _localEmergencyController;
  late TextEditingController _personalEmergencyController;

  @override
  void initState() {
    super.initState();
    _localEmergencyController = TextEditingController();
    _personalEmergencyController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: authProvider.getUserData.role == 'Husband' ? blue1 :kRedBackground,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: authProvider.getUserData.role == 'Husband' ? Image.asset('assets/male_stitch.png') : Image.asset('assets/female_stitch.png'),
        ),
        actions: <Widget>[
          Row(
            children: [
              Text(
                "21",
                // '${now.day}',
                style: const TextStyle(color: Colors.black, fontSize: 36),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tuesday",
                    // weekdays[now.weekday % 7],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Feb 2023",
                    // '${weekmonths[now.month % 12]} ${now.year}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 50, 10, 5),
                child: Text("Local Emergency Number",
                    style: TextStyle(fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: TextField(
                  controller: _localEmergencyController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: authProvider.getUserData.role == 'Husband' ? blue1 :kRedBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                    hintText: 'Eg: 999',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 5),
                child: Text("Personal Contact Emergency",
                    style: TextStyle(fontSize: 17)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: TextField(
                  controller: _personalEmergencyController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: authProvider.getUserData.role == 'Husband' ? blue1 :kRedBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Eg: +60173462718',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color:  authProvider.getUserData.role == 'Husband' ? blue2 :kRed,
                      borderRadius:
                          BorderRadius.circular(20), // set the border radius
                    ),
                    child: TextButton(
                      child: const Text('Save',
                          style: TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255))),
                      onPressed: () {
                        authProvider.saveEmergencyNumber(_localEmergencyController.text, _personalEmergencyController.text, authProvider.getUserData.id).then((value) {
                          Navigator.pop(context);
                        });
                      },
                    ),
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
