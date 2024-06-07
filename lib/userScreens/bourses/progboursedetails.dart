import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/colors.dart';

class ProgBourseDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  const ProgBourseDetails(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
           const Icon(
                  FontAwesomeIcons.handPointRight,
                  color: mainColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 20,
                ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15.0, color:Colors.blue , fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
