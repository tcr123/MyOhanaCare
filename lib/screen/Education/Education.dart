import 'package:flutter/material.dart';
import "package:ohana_care/model/information.dart";
import 'package:ohana_care/screen/Education/EducationDetails.dart';
import 'package:ohana_care/screen/homepage/homepage.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../widget/EducationList.dart';
import '../../widget/EducationCard.dart';
import 'package:ohana_care/provider/education_provider.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {

  List<Information> futureInformation =[]; 

  String selectedTopic = '';
  int selectedIndex = -1;
  Set<String> categories = Set(); // Define a Set to hold unique categories

  // fetch education data from backend
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final educationProvider =
        Provider.of<EducationProvider>(context, listen: false);

    educationProvider.fetchEducation(authProvider.getUserData.id).then((value){
      setState(() {
        futureInformation=value;
        for (var info in futureInformation) {
          categories.add(info.category); // Add each category to the Set
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final educationProvider = Provider.of<EducationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //appbar

          SizedBox(height: 50),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Text(
                'Today',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'InterSemiBold ',
                  fontSize: 26,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),

          SizedBox(height: 25),

          Container(
            height: 35,
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String category = categories
                    .elementAt(index); // Get the category from the Set
                return EducationCard(
                    title: category,
                    onPressed: () {
                      setState(() {
                        selectedTopic = category;
                        selectedIndex = index;
                      });
                    },
                    textColor: selectedTopic == category
                        ? Color.fromARGB(255, 170, 166, 166)
                        : Colors.black);
              },
            ),
          ),

          SizedBox(height: 10),

          Container(
              height: MediaQuery.of(context).size.height - 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: futureInformation.length,
                  itemBuilder: (context, index) {
                    Information information = futureInformation[index];

                    if (selectedTopic.isEmpty ||
                        selectedTopic == information.category) {
                      return GestureDetector(
                        onTap: () {
                          educationProvider.postEducation(authProvider.getUserData.id, information.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EducationDetails(information)),
                          );
                        },
                        child: EducationList(
                          title: information.title,
                          logoImagePath: information.img,
                        ),
                      );
                    } else {
                      return SizedBox
                          .shrink(); // Return an empty SizedBox if the topic doesn't match
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }
}
