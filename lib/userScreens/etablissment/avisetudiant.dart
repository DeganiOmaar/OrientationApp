import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AvisEtudiant extends StatelessWidget {
  final String nom;
  final String avis;
  final String avisid;
  final String userid;
  const AvisEtudiant(
      {super.key,
      required this.nom,
      required this.avis,
      required this.avisid,
      required this.userid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0),
      child: Column(children: [
        const Gap(20),
        Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
            ),
            const Gap(20),
            Text(nom)
          ],
        ),
        const Gap(20),
        const Text("Avis d'un etudiants"),
        const Gap(10),
        Text(avis)
      ]),
    );
  }
}
