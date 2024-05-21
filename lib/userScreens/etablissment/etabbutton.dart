import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class EtablissementButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const EtablissementButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(mainColor),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 4.0)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: whiteColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
