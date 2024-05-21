// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:orientation_app/userScreens/profile/priflebutton.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../shared/colors.dart';
import 'formationhome.dart';

class UpdateFormation extends StatelessWidget {
  final String postid;
  final String titre;
  final String contenue;
  final String prix;
  final String instructeur;
  final String description;
  UpdateFormation(
      {super.key,
      required this.postid,
      required this.titre,
      required this.contenue,
      required this.prix,
      required this.instructeur,
      required this.description});

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController titreController = TextEditingController();

  TextEditingController contenueController = TextEditingController();

  TextEditingController instructeurController = TextEditingController();

  TextEditingController prixController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundgreyColor,
        title: const Text(
          "Mettre a jour la bourse",
          style: TextStyle(
              color: blackColor, fontWeight: FontWeight.w600, fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                const Gap(20),
                AddAvisTField(
                  title: 'titre',
                  text: titre,
                  controller: titreController,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(10),
                AddAvisTField(
                  title: 'Contenue du formation',
                  text: contenue,
                  controller: contenueController,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(10),
                AddAvisTField(
                  title: 'Description',
                  text: description,
                  controller: descriptionController,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(10),
                AddAvisTField(
                  title: 'Instructeur',
                  text: instructeur,
                  controller: instructeurController,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(10),
                AddAvisTField(
                  title: 'Prix de formation',
                  text: prix,
                  controller: prixController,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                        child: ProfileButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('formation')
                                  .doc(postid)
                                  .update({
                                "titre": titreController.text == ""
                                    ? titre
                                    : titreController.text,
                                "contenue": contenueController.text == ""
                                    ? contenue
                                    : contenueController.text,
                                "description": descriptionController.text == ""
                                    ? description
                                    : descriptionController.text,
                                "instructeur": instructeurController.text == ""
                                    ? instructeur
                                    : instructeurController.text,
                                "prix": prixController.text == ""
                                    ? prix
                                    : prixController.text,
                              });
                              // if(!mounted) return;
                              // ignore: use_build_context_synchronously
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'formation mis à jour avec succes!',
                                  onConfirmBtnTap: () {
                                    titreController.clear();
                                    contenueController.clear();
                                    instructeurController.clear();
                                    prixController.clear();
                                    descriptionController.clear();
                                    Get.off(() => const Formation());
                                    // Navigator.of(context).pop();
                                  });
                            },
                            textButton: "Mettre à jour le formation")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
