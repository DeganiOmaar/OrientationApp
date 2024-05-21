import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class DescriptionText extends StatelessWidget {
  final String descriptionText;
  const DescriptionText({super.key, required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      descriptionText,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: greyColor),
      textAlign: TextAlign.justify,
      // maxLines: 7,
      overflow: TextOverflow.fade,
    );
  }
}
