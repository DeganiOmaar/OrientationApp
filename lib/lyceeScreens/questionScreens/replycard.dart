import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../shared/colors.dart';

class ReplyCard extends StatelessWidget {
  final String reponseNom;
  final String reponse;
  const ReplyCard({super.key, required this.reponseNom, required this.reponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(reponseNom,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: mainColor)),
        const Gap(5),
        Text(
          reponse,
          style: const TextStyle(color: blackColor, fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.justify,
        ),
        const Gap(10)
      ],
    );
  }
}
