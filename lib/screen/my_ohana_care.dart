import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ohana_care/screen/homepage/homepage.dart';

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
    Text(
      'Index 1: Calendar',
      style: optionStyle,
    ),
    Text(
      'Index 2: Profile',
      style: optionStyle,
    ),
    Text(
      'Index 3: Map',
      style: optionStyle,
    ),
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
              icon: const Icon(Icons.person),
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}