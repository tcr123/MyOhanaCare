import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class editSOS extends StatelessWidget {
  const editSOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade100,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 50, 10, 10),
              child: Text("Local Emergency Number",
                  style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Eg: 999',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              child: Text("Personal Contact Emergency",
                  style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.red.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: 'Eg: +60173462718',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // set the border color
                      width: 1, // set the border width
                    ),
                    borderRadius:
                        BorderRadius.circular(10), // set the border radius
                  ),
                  child: TextButton(
                    child: const Text('Save',
                        style: TextStyle(
                            color: Color.fromARGB(221, 203, 150, 150))),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
