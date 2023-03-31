import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:ohana_care/constant.dart';
import 'package:ohana_care/main.dart';
import 'package:ohana_care/model/information.dart';
import 'package:ohana_care/screen/Education/Education.dart';
import 'package:ohana_care/screen/calendar/calendar.dart';
import 'package:ohana_care/screen/homepage/editSOS.dart';
import 'package:ohana_care/screen/homepage/husband/first_half_second_trimester.dart';
import 'package:ohana_care/screen/homepage/husband/first_half_third_trimester.dart';
import 'package:ohana_care/screen/homepage/husband/first_half_trimester.dart';
import 'package:ohana_care/screen/homepage/husband/second_half_second_trimester.dart';
import 'package:ohana_care/screen/homepage/husband/second_half_trimester.dart';
import 'package:ohana_care/screen/homepage/wife/wife_first_half_second_trimester.dart';
import 'package:ohana_care/screen/homepage/wife/wife_first_half_third_trimester.dart';
import 'package:ohana_care/screen/homepage/wife/wife_first_half_trimester.dart';
import 'package:ohana_care/screen/homepage/wife/wife_second_half_second_trimester.dart';
import 'package:ohana_care/screen/homepage/wife/wife_second_half_third_trimester.dart';
import 'package:ohana_care/screen/homepage/wife/wife_second_half_trimester.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../model/event.dart';
import '../../model/pregnancy_data.dart';
import '../../model/push_notification.dart';
import '../../provider/auth_provider.dart';
import '../../provider/calendar_provider.dart';
import '../../widget/EducationHome.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ohana_care/provider/education_provider.dart';

import 'husband/second_half_third_trimester.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color red1 = Color.fromRGBO(246, 226, 222, 1);
  static const Color red2 = Color(0xffD49082);
  

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  final number = '+60176865849';

  // notification
  String? mToken = " ";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(); 

  List<Information> futureInformation =[]; 

  List<EventData> _futureUserEvents = [];
  PregnancyData? _futurePregnancyDate;
  
  // homepage that will show pregnancy info, events and education of this app
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final educationProvider =
        Provider.of<EducationProvider>(context, listen: false);

    final calendarProvider = Provider.of<CalendarProvider>(context, listen: false);
    // fetch education and calendar data 
    WidgetsBinding.instance.addPostFrameCallback((_){
      educationProvider.fetchEducation(authProvider.getUserData.id).then((value){
        if (!mounted) return;
        setState(() {
          futureInformation=value;
        });
      });
      calendarProvider.fetchUserTodayEvent(authProvider.getUserData.id).then((value) {
        if (!mounted) return;
        setState(() {
          _futureUserEvents = value;
        });
      });
      calendarProvider
          .fetchUserPregnancy(authProvider.getUserData.id)
          .then((value) {
        if (value == null) return;
        if (!mounted) return;
        setState(() {
          _futurePregnancyDate = value;
        });
      });
    });

    // notification
    requestPermission();
    getToken(authProvider.getUserData.id);
  }

  // request the permission to receive notification
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // get Token for this phone by firebase messaging
  void getToken(String id) async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mToken = token;
      });
      saveToken(token!, id);
    });
  }

  // save Token which is get from firebase messaging
  void saveToken(String token, String id) async {
    var url = Uri.parse('https://sticheapi.vercel.app/api/token');
    var response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $id"
      },
      body: jsonEncode({
        'token': token
      }));
    print(response.statusCode);
  }

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
                if (_futurePregnancyDate != null) dailyHighlight(_futurePregnancyDate!,authProvider.getUserData.role),
                if (_futureUserEvents.isNotEmpty) dailyEvents(_futureUserEvents, context),
                if (futureInformation.isNotEmpty) education(context, futureInformation),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // daily Highlight will show the pregnancy data of wife to husband and wife
  Widget dailyHighlight(PregnancyData pregnancyData,String role) {
    DateTime startDay = DateTime.parse(pregnancyData.lastDayPeriod);
    startDay = DateTime.utc(startDay.year, startDay.month, startDay.day);
    DateTime lastDay = DateTime.parse(pregnancyData.expectedDeliveryDate);
    lastDay = DateTime.utc(lastDay.year, lastDay.month, lastDay.day);
    DateTime now = DateTime.now();

    String phase = "";
    Duration checkingPhase = now.difference(startDay);
    if ((checkingPhase.inDays / 7) + 1 >= 1 && (checkingPhase.inDays / 7) + 1 <= 13) {
      phase = "first trimester";
    } else if ((checkingPhase.inDays / 7) + 1 >= 14 && (checkingPhase.inDays / 7) + 1 <= 27) {
      phase = "second trimester";
    } else if ((checkingPhase.inDays / 7) + 1 >= 28 && (checkingPhase.inDays / 7) + 1 <= 40) {
      phase = "third trimester";
    }
    Duration weekLeft = lastDay.difference(now);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text('Daily Highlights',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
            ),
            
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: role == 'Husband' ? blue2 : kRed,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 0, 0),
                    child: Row(
                      children: [
                        
                        Image.asset(role == 'Husband' ? "assets/icons/Pregnant_blue.png" : "assets/icons/pregnant.png"),
                        const Text("Pregnancy Cycle"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                        child: CircularPercentIndicator(
                          radius: 45.0,
                          lineWidth: 7.0,
                          percent: ((checkingPhase.inDays / 7) / (weekLeft.inDays / 7 + checkingPhase.inDays / 7)),
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(((checkingPhase.inDays / 7).toInt() + 1).toString(), style: const TextStyle(color: Colors.black)),
                              const Text("Weeks", style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          progressColor: role == 'Husband' ? blue2:kRed,
                        )
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "PHASE",
                            style: TextStyle(
                                color: role == 'Husband' ? blue2:kRed,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(phase),
                          Text(""),
                          Text("Milestone",
                              style: TextStyle(
                                  color: role == 'Husband' ? blue2:kRed,
                                  fontWeight: FontWeight.w500)),
                          Text("${((weekLeft.inDays / 7).toInt() + 1).toString()} weeks to go!"),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 2, 15, 0),
                    child: Divider(color: role == 'Husband' ? blue2 :red2),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((checkingPhase.inDays / 7) + 1 >= 1 && (checkingPhase.inDays / 7) + 1 <= 7)
                            role == 'Husband' 
                            ? const Text("Did you know that your baby's heart begins to beat during the first few weeks of pregnancy? Learn more about your baby's development and how it affects your wife's body in the first trimester.")
                            : const Text("Is your baby already hiccupping? Discover the amazing developments during the first half of the first trimester!")
                          else if ((checkingPhase.inDays / 7) + 1 >= 8 && (checkingPhase.inDays / 7) + 1 <= 13)
                            role == 'Husband'
                            ? const Text("Did you know that your baby is already growing fingernails and toenails at 12 weeks? Learn more about your baby's development and how to support your wife during the second half of the first trimester.")
                            : const Text("Did you know your baby's brain starts to form during the second half of the first trimester? Learn about the incredible developments happening in your little one's body in the early stages of pregnancy.")
                          else if ((checkingPhase.inDays / 7) + 1 >= 14 && (checkingPhase.inDays / 7) + 1 <= 20)
                            role == 'Husband'
                            ? const Text("Dads, did you know your baby's senses are developing rapidly in the second trimester? Read on to find out more!")
                            : const Text("Did you know your baby's senses are developing rapidly during the second trimester? Discover the amazing changes happening in your little one's body and what it means for their future.")
                          else if ((checkingPhase.inDays / 7) + 1 >= 21 && (checkingPhase.inDays / 7) + 1 <= 27) 
                            role == 'Husband'
                            ? const Text("Is your baby practicing breathing in the womb? Read on to find out more!")
                            : const Text("Baby's taste buds are developing! What foods should you be eating?")
                          else if ((checkingPhase.inDays / 7) + 1 >= 28 && (checkingPhase.inDays / 7) + 1 <= 34)
                            role == 'Husband'
                            ? const Text("Did you know that your baby's eyes are developing rapidly during the first half of the 3rd trimester? Find out more about your baby's development and how you can support your wife during this crucial stage of pregnancy.")
                            : const Text("Did you know your baby is practicing their breathing in the womb? Learn more fascinating facts about your baby's development in the first half of the third trimester.")
                          else if ((checkingPhase.inDays / 7) + 1 >= 35 && (checkingPhase.inDays / 7) + 1 <= 40)
                            role == 'Husband'
                            ? const Text("Get ready to meet your little one! Discover how your baby is putting on the finishing touches and your wife's body is preparing for labor and delivery in the final weeks of pregnancy.")
                            : const Text("Did you know that your baby's immune system is getting stronger every day during the third trimester? Read on to find out more!"),
                          const SizedBox(height: 10)
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
                            color: role == 'Husband' ? blue1 :Color.fromRGBO(246, 226, 222, 1), // set the background color
                            border: Border.all(
                              color: role == 'Husband' ? blue2 :red2, // set the border color
                              width: 1, // set the border width
                            ),
                          ),
                          child: TextButton(
                            child: const Text('Know More >>',
                                style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal)),
                            onPressed: () {
                              if ((checkingPhase.inDays / 7) + 1 >= 1 && (checkingPhase.inDays / 7) + 1 <= 7) {
                                role == 'Husband' 
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const FirstHalfTrimester()),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WifeFirstHalfTrimester()),
                                  );
                              }
                              else if ((checkingPhase.inDays / 7) + 1 >= 8 && (checkingPhase.inDays / 7) + 1 <= 13) {
                                role == 'Husband' 
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SecondHalfTrimester()),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WifeSecondHalfTrimester()),
                                  );
                              }
                              else if ((checkingPhase.inDays / 7) + 1 >= 14 && (checkingPhase.inDays / 7) + 1 <= 20) {
                                role == 'Husband' 
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const FirstHalfSecondTrimester()),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WifeFirstHalfSecondTrimester()),
                                  );
                              }
                              else if ((checkingPhase.inDays / 7) + 1 >= 21 && (checkingPhase.inDays / 7) + 1 <= 27) {
                                role == 'Husband' 
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SecondHalfSecondTrimester()),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WifeSecondHalfSecondTrimester()),
                                  );
                              }
                              else if ((checkingPhase.inDays / 7) + 1 >= 28 && (checkingPhase.inDays / 7) + 1 <= 34) {
                                role == 'Husband' 
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const FirstHalfThirdTrimester()),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WifeFirstHalfThirdTrimester()),
                                  );
                              }
                              else if ((checkingPhase.inDays / 7) + 1 >= 35 && (checkingPhase.inDays / 7) + 1 <= 40) {
                                role == 'Husband' 
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SecondHalfThirdTrimester()),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const WifeSecondHalfThirdTrimester()),
                                  );
                              }
                            },
                          ),
                        ),
                      ],
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

// show dailyEvents of wife and husband
Widget dailyEvents(List<EventData> events, BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Text(
                    'Events',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(0xFF977C45),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                ...events.map((event) =>
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                    child: Row(
                      children: [
                        Image.asset(event.role == 'Husband' ? "assets/icons/event_male.png" : "assets/icons/event.png", width: 32, height: 32),
                        const SizedBox(width: 10),
                        Text(event.eventName),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
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
                            color: Color(0xFF977C45), // set the border color
                            width: 1, // set the border width
                          ),
                        ),
                        child: TextButton(
                          child: const Text('View Details',
                              style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal)),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Calendar()));
                          },
                        ),
                      ),
                    ],
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

// show education info related to wife care 
Widget education(BuildContext context, List<Information> futureInformation) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
    child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("We care for your family.",
                      style: TextStyle(fontSize: 18)),

                  TextButton(
                  child: const Text(
                    'View All >>',
                    style: TextStyle(color: Colors.black87,fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Education()),
                    );
                  },
                ),

                  
                      
                ],
              ),
            ),
        
        Container(
          height: 240,
          child: ListView.builder(
            itemCount: futureInformation.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Information information = futureInformation[index];
              return EducationHome(
                title: information,
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

  void sendPushMessage(String token, String body, String title) async {
    try {
      final response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAGbXb_Vg:APA91bGndbvfWsp-MF8GAYvZTsO9U-42SKbm4QSZO2_1BZViISAuPt6naNAYUCjtWBdg-vAvP7vUTwuQVm5yYV3tZ7WGjqdK2AFjb65oOjL98n6wbXJJiVZ0oxWtaGT98TRJtEqqnmeb'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic> {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title
            },
            "notification": <String, dynamic> {
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token
          }
        )
      );
      print(response.statusCode);
    } catch (e) {
      if (kDebugMode) {
        print("error push notification");
      }
    }
  }

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
          child: buildButton(shrinkOffset, authProvider.getUserData.role, authProvider.getUserData.localEmergencyNumber, authProvider.getUserData.id),
        ),
        
        Positioned(
          top: 220,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset, context,authProvider.getUserData.role),
        ),
        Positioned(
          top: 90,
          left: 260,
          right: 40,
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
          height: 275,
          color: role == 'Husband' ? blue1 : Color.fromRGBO(246, 226, 222, 1),
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

  Widget buildButton(double shrinkOffset, String role, String localEmergencyNumber, String token) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: GestureDetector(
        onTap: () async {
          bool res = await FlutterPhoneDirectCaller.callNumber(localEmergencyNumber) as bool;
          // _calledNumber;
          var url = Uri.parse('https://sticheapi.vercel.app/api/token');
          var response = await http.get(url,
            headers: {
              "Authorization": "Bearer $token"
            });
          var jsonResponse = jsonDecode(response.body);
          print(jsonResponse);
          if(jsonResponse['message']=="200 success"){
            if (role == 'Husband') {
              sendPushMessage(jsonResponse['spouse']['token'], 'Your Husband is in danger', 'Notification');
            }
            else {
              sendPushMessage(jsonResponse['spouse']['token'], 'Your Wife is in danger', 'Notification');
            }
          }
        },
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

  Widget buildFloating(double shrinkOffset, BuildContext context,String role) {
    DateTime now = DateTime.now();
    role == 'Husband' ? blue1:Color.fromRGBO(246, 226, 222, 1);
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.61,
            height: 100,
            child: Card(
          
               
              shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: role == 'Husband' ? blue2 : kRed, width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Row(
                    
                      
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
                            style: TextStyle(
                                color: role == 'Husband' ? blue2:kRed,
                                fontSize: 18),
                          ),
                          Text(
                            '${weekmonths[now.month % 12]} ${now.year}',
                            style: const TextStyle(color: Colors.black, fontSize: 18),
                          )
                        ],
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => editSOS()),
                );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: role == 'Husband' ? blue2 : kRed, width: 1.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/editSOS.png"),
                        Text('Edit SOS',style: TextStyle(color: role == 'Husband' ? blue2:kRed),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
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
          backgroundColor: role == 'Husband' ? blue1:Color.fromRGBO(246, 226, 222, 1),
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 2600),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: kRed,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: kRed, width: 2.0),
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ScaleAnimatedText(
                    'Click me for HELP!',
                    duration: Duration(milliseconds: 2600),
                    textStyle:
                        TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.w500),
                    scalingFactor: 0.6,
                  ),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
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
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  // Widget EditContactButton(double shrinkOffset, BuildContext context) {
  //   return Opacity(
  //     opacity: disappear(shrinkOffset),
  //     child: Container(
  //       height: 30,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5),
  //         color: Colors.red.shade100, // set the background color
  //         border: Border.all(
  //           color: Colors.red.shade200, // set the border color
  //           width: 1, // set the border width
  //         ),
  //       ),
  //       child: Row(
  //         children: [
  //           TextButton(
  //             child: const Text('Edit SOS',
  //                 style:
  //                     TextStyle(color: Color.fromARGB(221, 203, 150, 150), fontSize: 12)),
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => editSOS()),
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}