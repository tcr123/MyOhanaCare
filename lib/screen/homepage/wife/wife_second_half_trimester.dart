import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

// pregnancy first trimester tips
class WifeSecondHalfTrimester extends StatefulWidget {
  const WifeSecondHalfTrimester({super.key});

  @override
  State<WifeSecondHalfTrimester> createState() => _WifeSecondHalfTrimesterState();
}

class _WifeSecondHalfTrimesterState extends State<WifeSecondHalfTrimester> {
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
                    "Learn about the incredible developments happening in your little one's body in the early stages of pregnancy.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Mummies-to-be, did you know that during the second half of your first trimester, your baby is developing at an astonishing rate? Here are some fascinating facts about your baby's growth and your body during this exciting time.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "First, let's talk about your baby.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "At around 8 weeks, your little one is about the size of a raspberry and has all of their major organs in place. They also have tiny fingers and toes, which are beginning to separate. By the end of this trimester, your baby will have grown to be around 3 inches long and weigh about half an ounce!",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "But it's not just your baby that's growing. ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Your uterus is also expanding to accommodate your growing little one. As a result, you may notice some changes in your body. For example, you may experience mild cramping or spotting as your uterus stretches and grows. You may also experience some morning sickness during this time, as well as fatigue and breast tenderness. These symptoms are all normal and are a sign that your body is working hard to support your developing baby.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Finally, it's important to note that during this time, your baby is especially vulnerable to certain substances, such as alcohol and tobacco.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "If you haven't already, now is the time to quit smoking and avoid alcohol and other harmful substances.",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Overall, the second half of the first trimester is an exciting time for both you and your baby.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "By taking care of yourself and your growing little one, you're setting the stage for a healthy and happy pregnancy.",
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
