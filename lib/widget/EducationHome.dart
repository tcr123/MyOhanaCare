import 'package:flutter/material.dart';
import 'package:ohana_care/model/information.dart';
import 'package:ohana_care/screen/Education/EducationDetails.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/education_provider.dart';

class EducationHome extends StatelessWidget {
  final Information title;

  EducationHome({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final educationProvider = Provider.of<EducationProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetails(title)));
          educationProvider.postEducation(authProvider.getUserData.id, title.id);
        },
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Color.fromRGBO(237, 235, 235, 0.612),
              borderRadius: BorderRadius.circular(14)),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 3.0),
              height: 150,
              child: Image.network(title.img),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    child: Text('${title.title.substring(0, 30)}...', style: TextStyle(fontSize: 15)))
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
