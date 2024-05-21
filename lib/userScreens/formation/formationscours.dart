import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class FormationCours extends StatelessWidget {
  final String coursName;
  final VoidCallback onPressed;
  const FormationCours({super.key, required this.coursName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: Text(
            coursName,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: mainColor),
          ),
        ),
      ),
    );
  }
}
