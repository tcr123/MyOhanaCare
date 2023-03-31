import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class WifeSecondHalfThirdTrimester extends StatefulWidget {
  const WifeSecondHalfThirdTrimester({super.key});

  @override
  State<WifeSecondHalfThirdTrimester> createState() => _WifeSecondHalfThirdTrimesterState();
}

class _WifeSecondHalfThirdTrimesterState extends State<WifeSecondHalfThirdTrimester> {
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
                      const Text("Second half of Third trimester ", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    "The second half of the third trimester is an exciting time for mummies as they approach the final stretch of their pregnancy. During this time, their baby undergoes significant changes and developments in their body and brain. Here are some interesting and fascinating facts that mummies would love to know about their baby's development during this period:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "1. Rapid brain development: During the final weeks of pregnancy, the baby's brain develops at an incredibly rapid rate, with the formation of new neural connections occurring at a rate of up to 2 million per second. This development continues after birth, with the first three years of life being critical for brain development.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "2. Baby's position: As the baby grows and the uterus expands, they will begin to shift into a head-down position in preparation for birth. This is known as the \"engagement\" or \"lightening\" process, which typically occurs in the last few weeks of pregnancy.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "3. Building immunity: During the final weeks of pregnancy, the baby's immune system is actively developing, with antibodies being transferred from the mother to the baby to help protect against infections and illnesses.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "4. Weight gain: In the last few weeks of pregnancy, the baby will continue to gain weight, adding an average of half a pound per week. This weight gain is essential for the baby's growth and development, and mummies can expect to feel their baby's movements becoming more prominent as they get larger.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "5. Final touches: During the final weeks of pregnancy, the baby's organs and systems will continue to mature and develop, with a particular focus on the respiratory and digestive systems. Additionally, the baby's nails will grow and may need to be trimmed shortly after birth.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "In conclusion, the second half of the third trimester is a time of rapid development and preparation for birth. Mummies can take comfort in knowing that their baby is building their immune system, gaining weight, and preparing for life outside the womb. With just a few more weeks to go, the countdown to meeting their little one is on!",
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
