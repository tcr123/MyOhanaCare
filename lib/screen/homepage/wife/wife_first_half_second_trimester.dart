import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class WifeFirstHalfSecondTrimester extends StatefulWidget {
  const WifeFirstHalfSecondTrimester({super.key});

  @override
  State<WifeFirstHalfSecondTrimester> createState() => _WifeFirstHalfSecondTrimesterState();
}

class _WifeFirstHalfSecondTrimesterState extends State<WifeFirstHalfSecondTrimester> {
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
                      const Text("First half of Second trimester ", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    "Pregnancy is an exciting and life-changing experience, filled with many ups and downs. For expectant mothers, it can be a time of wonder and anticipation as they eagerly await the arrival of their little one. During the first half of the second trimester, which is between weeks 13 and 16 of pregnancy, there are many incredible developments happening in the baby's body. Here are some fascinating facts that mummies would love to know about their babies' development during this stage:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "1. Baby's gender is now visible: By the end of the first trimester, the baby's genitals have begun to form, but it's not until the second trimester that they become more visible on an ultrasound scan. This is an exciting time for parents who are eager to find out the gender of their baby.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "2. Baby's senses are developing: During the second trimester, the baby's senses start to develop rapidly. Their eyes and ears move into their final positions, and they can hear their mother's voice and heartbeat, as well as other external sounds."
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "3. Baby is growing rapidly: By the end of the first trimester, the baby is about 3 inches long and weighs around 1 ounce. But by the end of the second trimester, they will have grown to around 14 inches long and weigh around 2 pounds. This rapid growth is necessary to prepare the baby for life outside the womb.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "4. Baby's skin is becoming less transparent: During the second trimester, the baby's skin starts to thicken and become less transparent, making it harder to see the baby's internal organs on an ultrasound scan.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "5. Baby is practicing breathing: Even though the baby's lungs are not yet fully developed, they start practicing breathing movements during the second trimester. This is an important step in preparing them for breathing on their own after birth.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "As mummies progress through the second trimester, they will continue to experience many changes in their body and in their baby's development. By staying informed and aware of these changes, they can better prepare for the exciting journey ahead.",
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
