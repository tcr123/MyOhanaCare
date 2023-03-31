import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class WifeFirstHalfThirdTrimester extends StatefulWidget {
  const WifeFirstHalfThirdTrimester({super.key});

  @override
  State<WifeFirstHalfThirdTrimester> createState() => _WifeFirstHalfThirdTrimesterState();
}

class _WifeFirstHalfThirdTrimesterState extends State<WifeFirstHalfThirdTrimester> {
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
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(246, 226, 222, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(authProvider.getUserData.role == 'Husband' ? "assets/male_stitch.png" : "assets/female_stitch.png"),
        ),
        actions: <Widget>[
          Row(
            children: [
              Text(
                now.day.toString(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffD49082), // Set the border color here
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 0, 10),
                  child: Row(
                    children: [
                      Image.asset("assets/Pregnant.png"),
                      const Text("First half of Third trimester ", style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Divider(color: Colors.red.shade400),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Congratulations, mom-to-be! You have made it to the first half of the third trimester of your pregnancy, and your baby is growing and developing at an incredible pace. Here are some interesting and fascinating facts about your baby's development and your body during this exciting time:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "1. Your baby's lungs are developing rapidly: At this stage, your baby's lungs are almost fully developed, and he/she is practicing breathing by inhaling and exhaling amniotic fluid. This practice helps to prepare the lungs for breathing air after birth.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "2. Your baby's brain is growing: Your baby's brain is developing rapidly during this time, with billions of new neurons forming every day. This growth spurt will continue throughout the third trimester and into early childhood.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "3. Your baby can hear your voice: By now, your baby's ears have developed enough for him/her to hear your voice and other sounds outside the womb. So, talk, sing, and read to your baby to help stimulate his/her brain and bond with him/her.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "4. You may experience shortness of breath: As your baby grows and takes up more space in your abdomen, you may feel short of breath or have difficulty breathing. This is normal, and you can try to alleviate it by practicing deep breathing exercises or sleeping propped up with pillows.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "5. Your baby is gaining weight: During the first half of the third trimester, your baby will gain most of his/her weight, growing from around 2 pounds to around 5 pounds. This weight gain will help your baby prepare for life outside the womb.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "These are just a few of the fascinating facts about your baby's development and your body during the first half of the third trimester. Enjoy this special time as you prepare for the arrival of your little one!",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
