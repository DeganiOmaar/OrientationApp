// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/shared/descriptiontext.dart';
import 'package:orientation_app/shared/details.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orientation_app/shared/titletext.dart';
import 'package:orientation_app/userScreens/etablissment/ajouteravisetudiant.dart';
import 'package:orientation_app/userScreens/etablissment/avisetablissmenet.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementHome.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementbutton.dart';
import 'package:orientation_app/userScreens/etablissment/etablissmentinfo.dart';
import 'package:orientation_app/userScreens/etablissment/tousavis.dart';
import 'package:orientation_app/userScreens/etablissment/updateetablissement.dart';

class EtablissementDetails extends StatefulWidget {
  final String faculteid;
  final String imgLink;
  final String universite;
  final String faculte;
  final String nombre;
  final String localisation;
  final String description;
  final String linkedin;
  final String site;
  final String telephone;
  const EtablissementDetails(
      {super.key,
      required this.faculteid,
      required this.universite,
      required this.faculte,
      required this.nombre,
      required this.localisation,
      required this.description,
      required this.linkedin,
      required this.site,
      required this.telephone,
      required this.imgLink});

  @override
  State<EtablissementDetails> createState() => _EtablissementDetailsState();
}

class _EtablissementDetailsState extends State<EtablissementDetails> {
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
      print(e.toString());
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
          appBar: AppBar(
    centerTitle: true,
    title: Text(
      "Plus de détails",
      style: TextStyle(color: blackColor, fontWeight: FontWeight.w600),
    ),
    actions: [
      userData['role'] == 'baccalauréat/licence'
          ? IconButton(
              onPressed: () {
                Get.off(() => AjouterAvisEtudiant(
                      faculteid: widget.faculteid,
                      userid: userData['uid'],
                    ));
              },
              icon: Icon(CupertinoIcons.add_circled))
          : userData['role'] == 'admin'
              ? IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection("etablissment")
                        .doc(widget.faculteid)
                        .delete();
                    Get.off(() => Etablissement());
                  },
                  icon: const Icon(
                    CupertinoIcons.delete_simple,
                    color: Colors.red,
                  ))
              : Container(),
      SizedBox(
        width: 5,
      ),
      userData['role'] == 'admin'
          ? IconButton(
              onPressed: () {
                Get.to(() => UpdateEtablissements(
                      faculteid: widget.faculteid,
                      universiteNom: widget.universite,
                      faculteNom: widget.faculte,
                      description: widget.description,
                      localisation: widget.localisation,
                      linkedin: widget.linkedin,
                      siteWeb: widget.site,
                    ));
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
    child: ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
    
               child: FancyShimmerImage(
          imageUrl: widget.imgLink,
          // boxFit: BoxFit.cover,
          width: 120,
          height: 115,
          errorWidget: const Icon(Icons.error),
        ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.universite,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.faculte,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Details(
                icons: Iconsax.location, description: widget.localisation),
            SizedBox(
              width: 20,
            ),
            Details(
                icons: Icons.network_cell,
                description: "Licenece | Ingenieurie | Master"),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Details(icons: Icons.school, description: widget.nombre),
        SizedBox(
          height: 10,
        ),
        TitleText(title: "Description"),
        SizedBox(
          height: 10,
        ),
        DescriptionText(descriptionText: widget.description),
        SizedBox(
          height: 10,
        ),
        EtablissementInfo(
            icons: FontAwesomeIcons.linkedin, text: widget.linkedin),
        SizedBox(
          height: 10,
        ),
        EtablissementInfo(
            icons: FontAwesomeIcons.chrome, text: widget.site),
        SizedBox(
          height: 10,
        ),
        EtablissementInfo(
            icons: FontAwesomeIcons.mapLocation, text: widget.localisation),
        SizedBox(
          height: 10,
        ),
        EtablissementInfo(
            icons: FontAwesomeIcons.phone, text: widget.telephone),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EtablissementButton(onPressed: () {}, text: " Licence "),
            EtablissementButton(onPressed: () {}, text: "Ingenieurie"),
            EtablissementButton(onPressed: () {}, text: " Master "),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(child: TitleText(title: "Avis sur les Etablissments")),
            InkWell(
                onTap: () {
                  Get.to(() => AllAvis(faculteid: widget.faculteid,));
                },
                child: Expanded(
                    child: Text(
                  "Voir tous",
                  style: TextStyle(
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                  ),
                )))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        DescriptionText(
            descriptionText:
                "Découvrez que les mombres de notre communuaté ont a dire sur les établissment scolaires, unioversitaires et de formations."),
        SizedBox(
          height: 10,
        ),
    
        Expanded(
          // height: 200,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('etablissment')
                .doc(widget.faculteid)
                .collection("AvisEtudiants")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
    
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      size: 32,
                      color: const Color.fromARGB(255, 16, 16, 16),
                      secondRingColor: Colors.indigo,
                      thirdRingColor: Colors.pink.shade400),
                );
              }
    
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return AvisEtablissement(
                      name: data['nom'],
                      description: data['avis'],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      
        SizedBox(
          height: 20,
        )
      ],
    ),
          ),
        );
  }
}
