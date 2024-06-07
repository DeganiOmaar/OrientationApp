import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementHome.dart';
import 'package:orientation_app/userScreens/profile/priflebutton.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class UpdateEtablissements extends StatefulWidget {
  final String faculteid;
  final String universiteNom;
  final String faculteNom;
  final String description;
  final String localisation;
  final String linkedin;
  final String siteWeb;

  const UpdateEtablissements({
    super.key,
    required this.faculteid,
    required this.universiteNom,
    required this.faculteNom,
    required this.description,
    required this.localisation,
    required this.linkedin,
    required this.siteWeb,
  });

  @override
  State<UpdateEtablissements> createState() => _UpdateEtablissementsState();
}

class _UpdateEtablissementsState extends State<UpdateEtablissements> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController faculteController = TextEditingController();
  TextEditingController universiteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController localisationController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController siteWebController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
    centerTitle: true,
    backgroundColor: backgroundgreyColor,
    title: const Text(
      "Mettre a jour l'etablissement",
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
              title: 'Nom de Universite',
              text: widget.universiteNom,
              controller: universiteController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Nom du faculté',
              text: widget.faculteNom,
              controller: faculteController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Description',
              text: widget.description,
              controller: descriptionController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Localisation',
              text: widget.localisation,
              controller: localisationController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Linkedin',
              text: widget.linkedin,
              controller: linkedinController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Site Web',
              text: widget.siteWeb,
              controller: siteWebController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(20),
            // Spacer(),
            Row(
              children: [
                Expanded(
                    child: ProfileButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('etablissment')
                              .doc(widget.faculteid)
                              .update({
                            "universite": universiteController.text == ""
                                ? widget.universiteNom
                                : universiteController.text,
                            "faculte": faculteController.text == ""
                                ? widget.faculteNom
                                : localisationController.text,
                            "description": descriptionController.text == ""
                                ? widget.description
                                : descriptionController.text,
                            "localisation":
                                localisationController.text == ""
                                    ? widget.localisation
                                    : localisationController.text,
                            "linkedin": linkedinController.text == ""
                                ? widget.linkedin
                                : linkedinController.text,
                            "siteWeb": siteWebController.text == ""
                                ? widget.siteWeb
                                : siteWebController.text,
                          });
                          // if(!mounted) return;
                          // ignore: use_build_context_synchronously
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Etablissement mis à jour avec succes!',
                              onConfirmBtnTap: () {
                                faculteController.clear();
                                universiteController.clear();
                                descriptionController.clear();
                                localisationController.clear();
                                linkedinController.clear();
                                siteWebController.clear();
                                // Navigator.of(context).pop();
                                Get.off(() => const Etablissement());
                              });
                        },
                        textButton: "Mettre à jour l'etablissement")),
              ],
            ),
          ],
        ),
      ),
    ),
          ),
        );
  }
}
