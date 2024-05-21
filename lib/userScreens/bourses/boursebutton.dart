import 'package:flutter/material.dart';

import '../../shared/colors.dart';

class BourseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String textButton;
  const BourseButton({super.key, required this.onPressed, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return 
    
    
    
    ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(mainColor),
          //  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child:  Text(
          textButton,
          style: const TextStyle(fontSize: 13, color: whiteColor),
        ));
  }
}
