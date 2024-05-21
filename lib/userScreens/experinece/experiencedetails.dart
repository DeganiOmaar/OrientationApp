import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orientation_app/shared/descriptiontext.dart';
import '../../shared/colors.dart';

class ExperienceDetails extends StatelessWidget {
  final String imgLink;
  final String nom;
  final String filiere;
  final String description;
  const ExperienceDetails(
      {super.key,
      required this.imgLink,
      required this.nom,
      required this.filiere,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
    backgroundColor: backgroundgreyColor,
    title: const Text(
      "Plus de Détails",
      style: TextStyle(color: blackColor, fontWeight: FontWeight.w600),
    ),
          ),
          body: Padding(
    padding:  const EdgeInsets.symmetric(horizontal: 20.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
           Row(
            children: [
                const CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nom,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    filiere,
                    style: const TextStyle(fontSize: 14, color: greyColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Liens Sociaux",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: blackColor),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(
                FontAwesomeIcons.facebook,
                color: mainColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                FontAwesomeIcons.github,
                color: mainColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                FontAwesomeIcons.linkedin,
                color: mainColor,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                FontAwesomeIcons.solidMessage,
                color: mainColor,
                size: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
           DescriptionText(
              descriptionText:
                  description),
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: BourseButton(
          //             onPressed: () {}, textButton: "Parcours Educatif")),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //         child: BourseButton(
          //             onPressed: () {}, textButton: "Experience")),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: BourseButton(
          //             onPressed: () {}, textButton: "Vie Etdiant")),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //         child: BourseButton(
          //             onPressed: () {}, textButton: "Realisation")),
          //   ],
          // )
       
        ],
      ),
    ),
          ),
        );
  }
}
