import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';

class EducationList extends StatelessWidget {
  final String title;
  final String logoImagePath;

  EducationList({
    required this.logoImagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 100),
            borderRadius: BorderRadius.circular(8)),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 3.0),
            height: 150,
            child: Image.asset(logoImagePath),
          ),
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Center(
                    child: Text(title, style: TextStyle(fontSize: 17)),
                  )),
            ],
          )
        ]),
      ),
    );
  }
}
