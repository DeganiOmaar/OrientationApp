import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: mainColor, ),
    );
  }
}
