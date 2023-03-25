import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../model/information.dart';

class EducationList extends StatelessWidget {
  final String title;
  final String logoImagePath;
  List<Information> futureInformation =[]; 


  EducationList({
    required this.logoImagePath,
    required this.title,
  });

  @override
 Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30.0),
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 251, 251, 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(logoImagePath),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Center(
              child: Text(title, style: TextStyle(fontSize: 17)),
            ),
          ),
        ],
      ),
    ),
  );
}


}
