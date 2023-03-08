import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ohana_care/screen/calendar/calendar.dart';
import 'package:ohana_care/screen/chatbot/chat_screen.dart';
import 'package:ohana_care/screen/homepage/homepage.dart';
import 'package:ohana_care/screen/location/multimarker.dart';
import 'package:ohana_care/screen/profile/profile.dart';

class MyOhanaCare extends StatefulWidget {
  const MyOhanaCare({super.key});

  @override
  State<MyOhanaCare> createState() => _MyOhanaCareState();
}

class _MyOhanaCareState extends State<MyOhanaCare> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _ohanaCareOptions = <Widget>[
    HomePage(),
    Calendar(),
    Profile(),
    MapMultiMarker()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _ohanaCareOptions.elementAt(_selectedIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          print("pressed");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            const SizedBox(width: 20),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                _onItemTapped(3);
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
