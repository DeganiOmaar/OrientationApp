import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class EtablissementInfo extends StatelessWidget {
  final IconData icons;
  final String text;
  const EtablissementInfo({super.key, required this.icons, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icons,
          size: 24,
          color: mainColor,
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
