import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class RegisterButton extends StatelessWidget {
  final String textButton;
  final VoidCallback? onPressed;
  const RegisterButton(
      {super.key, required this.textButton, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(mainColor),
           padding: MaterialStateProperty.all(const EdgeInsets.all(13)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
        ),
        child: Text(
          textButton,
          style: const TextStyle(fontSize: 16, color: whiteColor),
        ));
  }
}
