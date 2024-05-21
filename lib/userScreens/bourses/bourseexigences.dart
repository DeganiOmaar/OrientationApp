import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/colors.dart';

class BourseExigence extends StatelessWidget {
  final String description;
  const BourseExigence({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          FontAwesomeIcons.check,
          color: mainColor,
          size: 20,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
                  softWrap: true,
            description,
            style: const TextStyle(
              fontSize: 14.0,
              color: greyColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }
}
