import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/shared/descriptiontext.dart';
import 'package:orientation_app/shared/titletext.dart';
import 'package:orientation_app/userScreens/bourses/boursebutton.dart';
import 'package:orientation_app/userScreens/bourses/bourseexigences.dart';
import 'package:orientation_app/userScreens/bourses/bourseshome.dart';
import 'package:orientation_app/userScreens/bourses/inforbourses.dart';
import 'package:orientation_app/userScreens/bourses/progboursedetails.dart';
import 'package:orientation_app/userScreens/bourses/updatebourse.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsBourses extends StatelessWidget {
  final String bourseid;
  final String role;
  final String link;
  final String title;
  final String localisation;
  final String niveau;
  final String duree;
  final String travail;
  final String description;
  final String instutut;
  final String exigences1;
  final String exigences2;
  final String exigences3;
  const DetailsBourses(
      {super.key,
      required this.bourseid,
      required this.role,
      required this.link,
      required this.title,
      required this.localisation,
      required this.niveau,
      required this.duree,
      required this.travail,
      required this.description,
      required this.instutut,
      required this.exigences1,
      required this.exigences2,
      required this.exigences3});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(link);

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
          backgroundColor: backgroundgreyColor,
          appBar: AppBar(
    centerTitle: true,
    backgroundColor: backgroundgreyColor,
    title: const Text(
      "Plus de Détails",
      style: TextStyle(color: blackColor, fontWeight: FontWeight.w600),
    ),
    actions: [
      role == 'admin'
          ? IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("bourses")
                    .doc(bourseid)
                    .delete();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Bourses()));
              },
              icon: const Icon(
                CupertinoIcons.delete_simple,
                color: Colors.red,
              ))
          : Container(),
      const SizedBox(
        width: 5,
      ),
      role == 'admin'
          ? IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateBourse(
                            bourseid: bourseid,
                            titre: title,
                            localisation: localisation,
                            description: description,
                            exigences1: exigences1,
                            exigences2: exigences2,
                            exigences3: exigences3)));
              },
              icon: const Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.edit,
                color: blackColor,
              ))
          : Container(),
    ],
          ),
          body: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: SingleChildScrollView(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: blackColor),
            ),
                 const SizedBox(
              height: 20,
            ),
            Row(
              children: [
Expanded(child: 
   InfoBourses(
                text: "  $localisation ",
                icon: FontAwesomeIcons.locationDot),
),
const SizedBox(width: 30,), 
Expanded(child: 
 InfoBourses(
                    text: "  $niveau", icon: Icons.network_cell),
),

              ],
            ),
       
         
            const SizedBox(
                  height: 30,
                ),
               
          

            Row(
              children: [
                Expanded(child: 
                 InfoBourses(
                text: "  $duree", icon: FontAwesomeIcons.clock),
                ), 
                const SizedBox(width: 30,), 
                Expanded(child: 
                 InfoBourses(
                      text: "  $travail",
                      icon: FontAwesomeIcons.graduationCap),
                ),
              ],
            ),
          
               
           
            const SizedBox(
              height: 30,
            ),
            const TitleText(title: "Description"),
            const SizedBox(
              height: 10,
            ),
            DescriptionText(descriptionText: description),
            const SizedBox(
              height: 20,
            ),
            const TitleText(title: "Details du programme de bourse"),
            const SizedBox(
              height: 20,
            ),
            ProgBourseDetails(
                title: "Pays d'acceuil", subtitle: localisation),
            const SizedBox(
              height: 10,
            ),
            ProgBourseDetails(
                title: "Institut d'acceuil", subtitle: instutut),
            const SizedBox(
              height: 10,
            ),
            ProgBourseDetails(title: "Durée du programme", subtitle: duree),
            const SizedBox(
              height: 10,
            ),
            const TitleText(title: "Les exigences"),
            const SizedBox(
              height: 20,
            ),
            BourseExigence(description: exigences1),
            const SizedBox(
              height: 20,
            ),
            BourseExigence(description: exigences2),
            const SizedBox(
              height: 20,
            ),
            BourseExigence(description: exigences3),
            const SizedBox(
              height: 30,
            ), 
                            Row(
                              children: [
                                Expanded(
                                                  flex: 5,
                                                  child: BourseButton(
                                                      onPressed: _launchUrl, textButton: " Postuler "),
                                                      
                                                ),
                              ],
                            ),
                            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ),
          ),
        );
  }
}
