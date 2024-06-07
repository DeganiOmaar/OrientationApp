import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class InfoBourses extends StatelessWidget {
  final String text;
  final IconData icon;
  const InfoBourses({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
              child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              icon,
              color: mainColor,
              size: 18.0,
            ),
          )),
          TextSpan(
              text: text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
