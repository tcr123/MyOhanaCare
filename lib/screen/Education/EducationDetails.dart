import "package:flutter/material.dart";
import "package:ohana_care/model/information.dart";
import "Education.dart";

class EducationDetails extends StatelessWidget {
  final Information information;

  EducationDetails(this.information);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
        title: Text(
          "Ohana Cares",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.end,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  information.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  information.img,
                  width: screenWidth,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  information.description,
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  information.text,
                  style: TextStyle(fontSize: 17.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
