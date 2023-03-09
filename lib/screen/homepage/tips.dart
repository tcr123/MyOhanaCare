import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class tips extends StatelessWidget {
  const tips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/male_stitch.png'),
        ),
        actions: <Widget>[
          Row(
            children: [
              Text(
                "21",
                // '${now.day}',
                style: const TextStyle(color: Colors.black, fontSize: 36),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tuesday",
                    // weekdays[now.weekday % 7],
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Feb 2023",
                    // '${weekmonths[now.month % 12]} ${now.year}',
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
                color: Colors.red.shade400, // Set the border color here
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
                      Text("Doctor's Appointment"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Divider(color: Colors.red.shade400),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(
                    "How big is my baby at 20 weeks? ",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "You've got a heavyweight in your belly at 20 weeks pregnant (well, in baby terms, anyway). Your little champ weighs about 10 ounces and has a height, crown to rump, of about 6½ inches.While your baby is definitely getting bigger, there's still plenty of growing room in there, which allows him to twist and turn (and allows you to feel his acrobatics!).",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                  child: Text(
                    "Boy or Girl? ",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "Curious about whether that melon-sized belly has a boy or a girl inside? Now's your chance to take a peek! Though the external genitals in both male and female fetuses still have a way to grow, you'll be able to find out your baby's sex via the second trimester ultrasound, also known as the anatomy scan, usually scheduled for anytime between 18 and 22 weeks. You'll also get a detailed sneak peek at baby's other major organs and measurements and make sure your little one is developing normally. This exam, which is much longer than the routine ultrasounds you get at your doctor's office, gives your practitioner a chance to see how things are going in there — and wow, are they going! If you're carrying a girl, your baby's uterus is fully formed this week and the vaginal canal is starting its development; in a few decades, you might be a grandma! Your little girl also has primitive eggs in tiny ovaries now, about 7 million of them. By birth, that number will be down to 1 or 2 million. If your fetus is a boy, the testicles are begining their descent soon, though they're still in the abdomen waiting for the scrotum to finish growing so they'll have a place to go in a few weeks.",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
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
