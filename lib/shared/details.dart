import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class Details extends StatelessWidget {
  final IconData icons;
  final String description;
  const Details({super.key, required this.icons, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icons, color: mainColor, size: 18),
      const SizedBox(
        width: 6,
      ),
      Text(
        description,
        style: const TextStyle(fontSize: 15, color: blackColor, fontWeight: FontWeight.w600),
        
      )
    ]);
  }
}
