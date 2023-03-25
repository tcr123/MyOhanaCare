import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class editSOS extends StatelessWidget {
  const editSOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(246, 226, 222, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/male_stitch.png'),
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(246, 226, 222, 1),
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(246, 226, 222, 1),
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
                      color:  Color(0xffD49082),
                      borderRadius:
                          BorderRadius.circular(20), // set the border radius
                    ),
                    child: TextButton(
                      child: const Text('Save',
                          style: TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255))),
                      onPressed: () {},
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
