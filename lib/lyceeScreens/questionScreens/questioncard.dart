import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orientation_app/shared/colors.dart';

class QuestionCard extends StatelessWidget {
  final String nom;
  final String niveau;
  final String etablissement;
  final String question;
  const QuestionCard(
      {super.key,
      required this.nom,
      required this.niveau,
      required this.etablissement,
      required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(25),
        Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
            ),
            const Gap(10),
            Column(children: [
              Text(
                nom,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: mainColor),
              ),
              Text(
                niveau,
                style: const TextStyle(fontSize: 14, color: greyColor),
              ),
            ])
          ],
        ),
        const Gap(15),
        Text(etablissement,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const Gap(10),
        Text(
          question,
          style: const TextStyle(color: greyColor),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
