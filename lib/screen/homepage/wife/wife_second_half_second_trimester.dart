import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class WifeSecondHalfSecondTrimester extends StatefulWidget {
  const WifeSecondHalfSecondTrimester({super.key});

  @override
  State<WifeSecondHalfSecondTrimester> createState() => _WifeSecondHalfSecondTrimesterState();
}

class _WifeSecondHalfSecondTrimesterState extends State<WifeSecondHalfSecondTrimester> {
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
                      const Text("Second half of Second trimester ", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    "The second half of the second trimester is an exciting time for both mom and baby as the little one grows and develops at an incredible rate. Here are some fascinating facts that mummies would love to know about their baby's development during this stage of pregnancy.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "1. Baby's senses are fully developed: By the 24th week, your baby's senses are fully developed. They can now hear, see, taste, smell, and feel touch. They may even start to respond to sounds and voices outside of the womb.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "2. Baby's sleep-wake cycle is established: During the second half of the second trimester, your baby's sleep-wake cycle becomes more established. They may start to sleep and wake at regular intervals, which can be felt as movements and kicks.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "3. Baby's lungs are developing: By the 28th week, your baby's lungs are developing rapidly in preparation for breathing air after birth. The lungs produce a substance called surfactant, which helps the air sacs inflate and prevents them from collapsing.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "4. Baby is gaining weight: Your baby is growing rapidly during the second half of the second trimester, and by the end of this stage, they will weigh around 2-3 pounds. This weight gain is important for their growth and development, as well as for maintaining their body temperature after birth.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "5. Baby's brain is developing rapidly: During the second half of the second trimester, your baby's brain is developing rapidly. They are forming new neural connections and developing the ability to learn and remember. This is a crucial time for brain development, and proper nutrition and stimulation can help support your baby's brain growth.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "As your baby continues to develop and grow during the second half of the second trimester, it's important to take care of yourself and your little one. Eating a healthy diet, getting enough rest, and staying active can all help support your baby's growth and development. With each passing day, you're one step closer to meeting your precious bundle of joy!",
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
