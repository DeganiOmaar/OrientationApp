import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/shared/descriptiontext.dart';
import 'package:orientation_app/shared/titletext.dart';
import 'package:orientation_app/userScreens/formation/details.dart';
import 'package:orientation_app/userScreens/formation/formationhome.dart';
import 'package:orientation_app/userScreens/formation/formationsCours.dart';
import 'package:orientation_app/userScreens/formation/updateformation.dart';
import 'package:url_launcher/url_launcher.dart';

class FormationDetails extends StatefulWidget {
  final String instructeur;
  final String contenue;
  final String categorie;
  final String prix;
  final String certification;
  final String duree;
  final String type;
  final String description;
  final String email;
  final String numero;
  final String postid;
  final String titre;
  final String societeid;
  const FormationDetails({
    super.key,
    required this.instructeur,
    required this.contenue,
    required this.categorie,
    required this.prix,
    required this.certification,
    required this.duree,
    required this.type,
    required this.description,
    required this.email,
    required this.numero,
    required this.postid,
    required this.titre,
    required this.societeid,
  });

  @override
  State<FormationDetails> createState() => _FormationDetailsState();
}

class _FormationDetailsState extends State<FormationDetails> {
   Future<void> _launchUrl(phoneNumber) async {
    final Uri _url = Uri.parse('tel:$phoneNumber}');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  Map userData = {};
  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;
    } catch (e) {
      // print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: backgroundgreyColor,
          appBar: AppBar(
    backgroundColor: backgroundgreyColor,
    title: const Text(
      "Plus de détails",
      style: TextStyle(color: blackColor, fontWeight: FontWeight.w600),
    ),
    actions: [
      userData['role'] == 'société' && userData['uid'] == widget.societeid
          ? IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("formation")
                    .doc(widget.postid)
                    .delete();
                Get.off(() => const Formation());
              },
              icon: const Icon(
                CupertinoIcons.delete_simple,
                color: Colors.red,
              ))
          : userData['role'] == 'admin'
              ? IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("formation")
                        .doc(widget.postid)
                        .delete();
                    Get.off(() => const Formation());
                  },
                  icon: const Icon(
                    CupertinoIcons.delete_simple,
                    color: Colors.red,
                  ))
              : Container(),
      const SizedBox(
        width: 5,
      ),
      userData['role'] == 'société' && userData['uid'] == widget.societeid
          ? IconButton(
              onPressed: () {
                Get.to(() => UpdateFormation(
                    postid: widget.postid,
                    titre: widget.titre,
                    contenue: widget.contenue,
                    prix: widget.prix,
                    instructeur: widget.instructeur,
                    description: widget.description));
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
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
                  const Text(
                    "Instructeur",
                    style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.instructeur,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contenue,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.categorie,
                    style: const TextStyle(
                        fontSize: 14,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    widget.prix,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          elevation: 0,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          foregroundColor: Colors.black,
                          side: const BorderSide(
                            width: 1.0,
                            color: mainColor,
                          )),
                      child: const Text(
                        " S'inscrire ",
                        style: TextStyle(color: blackColor, fontSize: 15),
                      )),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailsFormation(
                text: widget.certification,
                icon: Icons.network_cell,
              ),
              DetailsFormation(
                  text: widget.duree, icon: FontAwesomeIcons.clock),
              DetailsFormation(
                  text: widget.type, icon: FontAwesomeIcons.book)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const TitleText(title: "Description"),
          const SizedBox(
            height: 10,
          ),
          DescriptionText(descriptionText: widget.description),
          const SizedBox(
            height: 10,
          ),
          // const TitleText(title: "Information supplémentaire"),
          const SizedBox(
            height: 10,
          ),
          FormationCours(coursName: widget.email, onPressed: () {  },),
          const SizedBox(
            height: 10,
          ),
          FormationCours(coursName: widget.numero, onPressed: ()async {

            await _launchUrl(widget.numero);
            },),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
          ),
        );
  }
}
