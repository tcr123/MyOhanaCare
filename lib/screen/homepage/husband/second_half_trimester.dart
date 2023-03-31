import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class SecondHalfTrimester extends StatefulWidget {
  const SecondHalfTrimester({super.key});

  @override
  State<SecondHalfTrimester> createState() => _SecondHalfTrimesterState();
}

class _SecondHalfTrimesterState extends State<SecondHalfTrimester> {
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
                      const Text("Second half of First trimester ", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    "Congratulations, daddy-to-be! Your partner has entered the second half of the first trimester of her pregnancy, and you may be wondering what's happening with your baby and her body. Here are some interesting and fascinating facts you'll love to know.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "1. Baby's major organs are developing: By the end of the second half of the first trimester, your baby's major organs, such as the heart, lungs, liver, and kidneys, have already started developing. The heart is beating at a steady pace, and your baby is now officially called a fetus.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "2. The placenta is fully formed: The placenta, which is responsible for providing your baby with oxygen and nutrients, is now fully formed. It will continue to grow throughout the pregnancy to meet the increasing demands of your growing baby.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "3. Your partner's uterus is expanding: As the baby grows, your partner's uterus is expanding, which may cause her to feel bloated or experience mild cramping. Her waistline may start to thicken, and she may need to start wearing looser clothing.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "4. Nausea and fatigue may improve: If your partner was experiencing morning sickness or fatigue, she may start to feel better during the second half of the first trimester. This is because the placenta is now taking over hormone production from the ovaries, which can reduce the severity of these symptoms.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "5. Baby's facial features are becoming more defined: Although your baby is still very small, their facial features are starting to become more defined. The eyes are moving closer together, the ears are taking shape, and the nose and lips are becoming more prominent.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Now that you know what's happening with your baby and your partner's body during the second half of the first trimester, you can be better prepared to support her and your growing family. Remember to attend prenatal appointments with your partner, eat a healthy diet, and get plenty of rest to support your partner during this exciting time.",
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
