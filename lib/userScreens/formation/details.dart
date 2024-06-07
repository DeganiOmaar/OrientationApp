import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class DetailsFormation extends StatelessWidget {
  final String text;
  final IconData icon;
  const DetailsFormation({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal:4.0),
      ),
      onPressed: () {},
      icon: Icon(
        icon,
        color: mainColor,
        size: 18.0,
      ),
      label:
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 15)),
    );
  }
}
