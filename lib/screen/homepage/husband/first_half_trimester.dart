import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class FirstHalfTrimester extends StatefulWidget {
  const FirstHalfTrimester({super.key});

  @override
  State<FirstHalfTrimester> createState() => _FirstHalfTrimesterState();
}

class _FirstHalfTrimesterState extends State<FirstHalfTrimester> {
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
        backgroundColor: Color.fromRGBO(246, 226, 222, 1),
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
                      const Text("First half of First trimester  ", style: TextStyle(fontWeight: FontWeight.bold),),
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
                    "Becoming a parent is an exciting journey, and there are a lot of things to learn along the way.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "If you are a dad-to-be, you may be curious about what is happening with your wife and your developing baby during the first trimester of pregnancy. This article will explore some fascinating facts about your baby's development and your wife's body during the first half of the first trimester.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "First, let's start with the baby's development.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "During the first few weeks of pregnancy, the fertilized egg travels down the fallopian tube and implants itself in the lining of the uterus. By week four, the baby's neural tube is forming, which will eventually become the brain and spinal cord. At this stage, the baby is about the size of a poppy seed.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Now let's talk about your wife's body.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "One of the most common symptoms of early pregnancy is morning sickness, which can actually occur at any time of day. This is caused by the hormonal changes in the body, particularly the increase in the hormone human chorionic gonadotropin (hCG). Your wife's breasts may also be tender and sore due to the increase in estrogen levels. Another interesting fact is that your wife's blood volume increases during the first trimester. This is because the body is working hard to support the growing baby, and it needs to pump more blood to do so. As a result, your wife's heart rate may increase slightly, and she may feel more tired than usual.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "It's important to note that every pregnancy is different, and your wife's experience may not match up exactly with what is described here.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "However, knowing these basic facts can help you understand what your wife is going through and provide support during this exciting time. In conclusion, the first few weeks of pregnancy are a crucial time for your developing baby and your wife's body. As a dad-to-be, you can play an important role in supporting your wife and learning about your baby's growth and development.",
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
