import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class EtablissementButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const EtablissementButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(secondaryColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      child: Text(
        text,
        style:const  TextStyle(fontSize: 13, color: whiteColor),
      ),
    );
  }
}
