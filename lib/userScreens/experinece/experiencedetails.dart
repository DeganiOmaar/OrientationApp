import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orientation_app/shared/descriptiontext.dart';
import '../../shared/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class ExperienceDetails extends StatelessWidget {
  final String imgLink;
  final String nom;
  final String filiere;
  final String description;
  final String facebook;
  final String gitHub;
  final String linkedin;
  const ExperienceDetails(
      {super.key,
      required this.imgLink,
      required this.nom,
      required this.filiere,
      required this.description,
      required this.facebook,
      required this.gitHub,
      required this.linkedin});

        Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        height: 8,
                      ),
                      Text(
                        filiere,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700),
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
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _launchURL(facebook),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.facebook,
                          color: mainColor,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          facebook,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(gitHub),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.github,
                          // color: blackColor,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          gitHub,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _launchURL(linkedin),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.linkedin,
                          color: mainColor,
                          size: 35,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                         linkedin,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       FontAwesomeIcons.solidMessage,
                  //       color: mainColor,
                  //       size: 20,
                  //     ),
                  //      SizedBox(width: 20,),
                  //     Text("deganiomar2001@gmail.com", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),)
                  //   ],
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DescriptionText(descriptionText: description),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
