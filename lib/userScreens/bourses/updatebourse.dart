import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/bourses/bourseshome.dart';
import 'package:orientation_app/userScreens/profile/priflebutton.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

// ignore: must_be_immutable
class UpdateBourse extends StatelessWidget {
  final String bourseid;
  final String titre;
  final String localisation;
  final String description;
  final String exigences1;
  final String exigences2;
  final String exigences3;
  UpdateBourse(
      {super.key,
      required this.bourseid,
      required this.titre,
      required this.localisation,
      required this.description,
      required this.exigences1,
      required this.exigences2,
      required this.exigences3});

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController titreController = TextEditingController();

  TextEditingController localisationController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController exigences1Controller = TextEditingController();

  TextEditingController exigences2Controller = TextEditingController();

  TextEditingController exigences3Controller = TextEditingController();

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
                  title: 'localisation',
                  text: localisation,
                  controller: localisationController,
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
                  title: 'Exigences1',
                  text: exigences1,
                  controller: exigences1Controller,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(10),
                AddAvisTField(
                  title: 'Exigences2',
                  text: exigences2,
                  controller: exigences2Controller,
                  validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },
                ),
                const Gap(10),
                AddAvisTField(
                  title: 'Exigences3',
                  text: exigences3,
                  controller: exigences3Controller,
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
                                  .collection('bourses')
                                  .doc(bourseid)
                                  .update({
                                "titre": titreController.text == ""
                                    ? titre
                                    : titreController.text,
                                "localisation":
                                    localisationController.text == ""
                                        ? localisation
                                        : localisationController.text,
                                "description": descriptionController.text == ""
                                    ? description
                                    : descriptionController.text,
                                "exigences1": exigences1Controller.text == ""
                                    ? exigences1
                                    : exigences1Controller.text,
                                "exigences2": exigences1Controller.text == ""
                                    ? exigences2
                                    : exigences2Controller.text,
                                "exigences3": exigences1Controller.text == ""
                                    ? exigences3
                                    : exigences3Controller.text,
                              });
                              // if(!mounted) return;
                               // ignore: use_build_context_synchronously
                               QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Bourse mis à jour avec succes!',
                                  onConfirmBtnTap: () {
                                    titreController.clear();
                                    localisationController.clear();
                                    descriptionController.clear();
                                    exigences1Controller.clear();
                                    exigences2Controller.clear();
                                    exigences3Controller.clear();
                                    Get.off(()=>const Bourses());
                                    // Navigator.of(context).pop();
                                  });
                            },
                            textButton: "Mettre à jour le bourse")),
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
