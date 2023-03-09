import 'package:flutter/material.dart';
import 'package:ohana_care/main.dart';
import 'package:ohana_care/screen/Education/Education.dart';
import 'package:ohana_care/screen/homepage/editSOS.dart';
import 'package:provider/provider.dart';
import '../../model/event.dart';
import '../../provider/auth_provider.dart';
import '../../provider/calendar_provider.dart';
import '../../widget/EducationHome.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'tips.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  final number = '+60176865849';

  List<EventData> _futureUserEvents = [];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // SliverAppBar(
          //   backgroundColor: Colors.red[100],
          //   toolbarHeight: 100,
          //   pinned: true,
          //   snap: false,
          //   floating: false,
          //   expandedHeight: 110.0,
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: const Text('Silver App Bar'),
          //   ),
          // ),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: CustomSliverDelegate(
              expandedHeight: 320,
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 30),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                dailyHighlight(),
                dailyEvents(),
                education(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget dailyHighlight() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red.shade200,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(14, 12, 12, 12),
              child: Text(
                'Daily Highlights',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Row(
                children: [
                  Image.asset("assets/Pregnant.png"),
                  Text("Pregnancy Cycle"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 20, 0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color.fromRGBO(239, 154, 154, 1),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("20", style: TextStyle(color: Colors.black)),
                          Text("Weeks", style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PHASE",
                      style: TextStyle(
                          color: Colors.red.shade200,
                          fontWeight: FontWeight.w500),
                    ),
                    Text("2nd Trimester"),
                    Text(""),
                    Text("WEEKS LEFT",
                        style: TextStyle(
                            color: Colors.red.shade200,
                            fontWeight: FontWeight.w500)),
                    Text("20 weeks to go!"),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 2, 15, 0),
              child: Divider(color: Colors.red.shade200),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("The big week?"),
                    Text(""),
                    Text(
                        "If you didn't start feeling your baby-to-be's punches and kicks last week, you may this week — and it's the best! But it could take a little longer."),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 2, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.shade100, // set the background color
                      border: Border.all(
                        color: Colors.red.shade200, // set the border color
                        width: 2, // set the border width
                      ),
                    ),
                    child: TextButton(
                      child: const Text('More Tips >>',
                          style: TextStyle(color: Colors.black87)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const tips()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget dailyEvents() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.red.shade200,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(14, 12, 12, 12),
            child: Text(
              'Events',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                Image.asset("assets/Pregnant.png"),
                Text("Doctor's Appointment"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 4, 20, 4),
            child: Divider(color: Colors.red.shade200),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 15, 4),
            child: Row(
              children: [
                Image.asset("assets/Pregnant.png"),
                Text("Company's Meeting"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 5, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(
                        255, 254, 244, 224), // set the background color
                    border: Border.all(
                      color: Color.fromARGB(
                          255, 151, 124, 69), // set the border color
                      width: 2, // set the border width
                    ),
                  ),
                  child: TextButton(
                    child: const Text('View Details',
                        style: TextStyle(color: Colors.black87)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget education(BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text("We care for your family.",
                  style: TextStyle(fontSize: 18)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    'More Tips >>',
                    style: TextStyle(color: Colors.black87),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Education()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 230,
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return EducationHome(
                title: "topic",
              );
            },
          ),
        ),
      ],
    ),
  );
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final number = '+60176865849';

  CustomSliverDelegate({
    required this.expandedHeight,
  });

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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final size = 190;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset, authProvider.getUserData.role),
        buildAppBar(shrinkOffset, authProvider.getUserData.role, DateTime.now()),
        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: buildText(shrinkOffset, authProvider.getUserData.name),
        ),
        Positioned(
          top: 80,
          left: 20,
          right: 20,
          child: buildButton(shrinkOffset, authProvider.getUserData.role),
        ),
        Positioned(
          top: 90,
          left: 18,
          right: 280,
          child: EditContactButton(shrinkOffset, context),
        ),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
        Positioned(
          top: 90,
          left: 240,
          right: 60,
          child: buildChat(shrinkOffset),
        ),
      ],
    );
  }

  Widget buildBackground(double shrinkOffset, String role) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: role == 'Husband' 
            ? const AssetImage('assets/male_stitch.png')
            : const AssetImage('assets/female_stitch.png'),
          radius: 50,
        ),
        Container(
          color: role == 'Husband' ? Colors.blue.shade100 : Colors.red.shade100,
        ),
      ],
    );
  }

  appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  // Widget buildFloating(double shrinkOffset) => Opacity(
  //       opacity: disappear(shrinkOffset),
  //       child: Card(
  //         child: Row(
  //           children: [
  //             Expanded(child: buildButton(text: 'Share', icon: Icons.share)),
  //             Expanded(child: buildButton(text: 'Like', icon: Icons.thumb_up)),
  //           ],
  //         ),
  //       ),
  //     );

  Widget buildButton(double shrinkOffset, String role) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: GestureDetector(
        onTap: _calledNumber,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 90,
          child: Center(child: Image.asset(role == 'Husband' ? "assets/male_stitch.png" : "assets/female_stitch.png")),
        ),
      ),
    );
  }

  _calledNumber() async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number) as bool;
  }

  Widget buildFloating(double shrinkOffset) {
    DateTime now = DateTime.now();
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red.shade200, width: 3.0),
        ),
        child: Row(
          children: [
            Image.asset('assets/home.png'),
            const SizedBox(width: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  now.day.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 42,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weekdays[now.weekday % 7],
                      style: const TextStyle(
                          color: Color.fromARGB(255, 235, 146, 140),
                          fontSize: 18),
                    ),
                    Text(
                      '${weekmonths[now.month % 12]} ${now.year}',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(width: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget buildButton({
  //   required String text,
  //   required IconData icon,
  // }) =>
  //     TextButton(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(icon),
  //           const SizedBox(width: 12),
  //           Text(text, style: TextStyle(fontSize: 20)),
  //         ],
  //       ),
  //       onPressed: () {},
  //     );

  // Widget buildFloating(double shrinkOffset) => Opacity(
  //       opacity: disappear(shrinkOffset),
  //       child: Card(
  //         child: Row(
  //           children: [
  //             Image.asset('assets/home.png'),
  //             Text("date"),
  //           ],
  //         ),
  //       ),
  //     );

  Widget buildAppBar(double shrinkOffset, String role, DateTime now) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          backgroundColor: role == 'Husband' ? Colors.blue.shade100 :Colors.red.shade100,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(role == 'Husband' ? "assets/male_stitch.png" : "assets/female_stitch.png"),
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
      );
  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
  Widget buildChat(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                ScaleAnimatedText('Click Me for help!',
                    duration: Duration(milliseconds: 2600),
                    textStyle:
                        TextStyle(fontSize: 14, color: Colors.red.shade300),
                    scalingFactor: 0.6)
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText(double shrinkOffset, String userName) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Center(
        child: Text(
          "Hi $userName, how is your day? ",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget EditContactButton(double shrinkOffset, BuildContext context) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red.shade100, // set the background color
          border: Border.all(
            color: Colors.red.shade200, // set the border color
            width: 2, // set the border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Image.asset("assets/edit.png"),
              TextButton(
                child: const Text('Edit SOS',
                    style:
                        TextStyle(color: Color.fromARGB(221, 203, 150, 150))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editSOS()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
