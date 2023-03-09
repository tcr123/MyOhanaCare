import 'package:flutter/material.dart';

class EducationHome extends StatelessWidget {
  final String title;

  EducationHome({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 10, 10),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Color.fromRGBO(237, 235, 235, 0.612),
            borderRadius: BorderRadius.circular(14)),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 3.0),
            height: 150,
            child: Image.asset("assets/education_home.png"),
          ),
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(title, style: TextStyle(fontSize: 15)),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
