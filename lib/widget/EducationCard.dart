import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color textColor;

  EducationCard({
    required this.title,
    required this.onPressed,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRect(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              padding: EdgeInsets.all(9.5),
              color: Color.fromRGBO(217, 217, 217, 100),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: textColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
