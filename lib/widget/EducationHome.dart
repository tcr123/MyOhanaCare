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
      padding: EdgeInsets.fromLTRB(0, 0, 13, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetails(title)));
          educationProvider.postEducation(authProvider.getUserData.id, title.id);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xFFD3ECFB),
              borderRadius: BorderRadius.circular(14)),
              
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 160,
                    width: 240,
                    child: Image.network(
                      title.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              SizedBox(height:10),

              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Container(
                  width: 240,
                  child: Text(
                    '${title.title.substring(0, 30)}...',
                    // '${title.title}',
                    style: TextStyle(fontSize: 15),
                    
                  ),
                ),
              ),

          ]),
        ),
      ),
    );
  }
}
