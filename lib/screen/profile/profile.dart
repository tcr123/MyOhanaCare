import 'package:flutter/material.dart';
import 'package:ohana_care/screen/auth/connect_spouse.dart';
import 'package:ohana_care/screen/my_ohana_care.dart';
import 'package:provider/provider.dart';
import 'package:ohana_care/screen/auth/sign_up.dart';
import 'package:ohana_care/screen/auth/sign_in.dart';
import '../../constant.dart';
import '../../provider/auth_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DateTime now = DateTime.now().toLocal();
  
  var weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  var weekmonths = [
    'Dec',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov'
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final name = authProvider.getUserData.name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRed,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image(
            image: authProvider.getUserData.role == "Husband"
                ? const AssetImage('assets/male_stitch.png')
                : const AssetImage('assets/female_stitch.png'),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Text(
                '${now.day}',
                style: const TextStyle(color: Colors.black, fontSize: 36),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weekdays[now.weekday % 7],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    '${weekmonths[now.month % 12]} ${now.year}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: authProvider.getUserData.role == "Husband"
                              ? const AssetImage('assets/male_stitch.png')
                              : const AssetImage('assets/female_stitch.png'),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(height: 15),
                Text('Hi, $name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                Column(
                  children: [
                    if (authProvider.getUserData.role == "Husband")
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 217, 217, 217),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConnectSpouse()));
                          },
                          child: const Text("Connect to Spouse",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 217, 217, 217),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        },
                        child: const Text("Sign Out",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
