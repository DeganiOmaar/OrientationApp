import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' show basename;

class AddEtablissement extends StatefulWidget {
  final String uid;
  const AddEtablissement({super.key, required this.uid});

  @override
  State<AddEtablissement> createState() => _AddEtablissementState();
}

class _AddEtablissementState extends State<AddEtablissement> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController universiteController = TextEditingController();
  TextEditingController faculteController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController localisationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController siteWebController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  File? imgPath;
  String? imgName;
  bool isLoading = false;
  uploadImage2Screen() async {
    final XFile? pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        imgPath = File(pickedImg.path);
        setState(() {
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  ajouterUnEtablissment() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("$imgName");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      CollectionReference course =
          FirebaseFirestore.instance.collection('etablissment');
      String newId = const Uuid().v1();
      course.doc(newId).set({
        'universite_id': widget.uid,
        'faculte_id': newId,
        "imgLink": urll,
        "universite": universiteController.text,
        "faculte": faculteController.text,
        "nombre": "${nombreController.text} Etudiants",
        "localisation": localisationController.text,
        "description": descriptionController.text,
        "linkedin": linkedinController.text,
        "siteWeb": siteWebController.text,
        "telephone": "+216 ${numeroController.text}",
      });
    } catch (err) {}
    setState(() {
      isLoading = false;
    });
  }
 
  afficherAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Etablissement ajouter avec succes!',
        onConfirmBtnTap: () {
          universiteController.clear();
          faculteController.clear();
          nombreController.clear();
          localisationController.clear();
          descriptionController.clear();
          linkedinController.clear();
          siteWebController.clear();
          numeroController.clear();
          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
    centerTitle: true,
    title: const Text(
      "Ajouter un établissement",
      style: TextStyle(
          fontSize: 17, color: blackColor, fontWeight: FontWeight.w700),
    ),
          ),
          body: SingleChildScrollView(
      child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Form(
      key: formstate,
      child: Column(
        children: [
          const Gap(10),
          Center(
            child: Stack(
              children: [
                imgPath == null
                    ? const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 225, 225, 225),
                        radius: 55,
                        backgroundImage:
                            AssetImage("assets/images/etabb.png", 
                            
                            ),
                      )
                    : ClipOval(
                        child: Image.file(
                          imgPath!,
                          width: 125,
                          height: 125,
                          fit: BoxFit.cover,
                        ),
                      ),
                Positioned(
                  left: 75,
                  bottom: -10,
                  child: IconButton(
                    onPressed: () {
                      uploadImage2Screen();
                    },
                    icon: const Icon(Icons.add_a_photo),
                    color: blackColor,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          AddAvisTField(
              title: 'Nom du Université',
              text: "Ajouter le nom d'université",
              controller: universiteController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: 'Nom du faculté',
              text: "Ajouter le nom",
              controller: faculteController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: "Nombre d'étudiants",
              text: "Ajouter le nombre d'étudiants",
              controller: nombreController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: "Localisation",
              text: "Ajouter l'adresse de l'université ",
              controller: localisationController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: "Description",
              text: "Ajouter une description",
              controller: descriptionController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: "Linkedin",
              text: "Ajouter nom de Linkedin",
              controller: linkedinController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: "Site Web",
              text: "Ajouter lien de site web",
              controller: siteWebController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: "Téléphone",
              text: "Ajouter Le Téléphone",
              controller: numeroController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(20),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                  
    
                            if (formstate.currentState!.validate()) {
                           await ajouterUnEtablissment();
                        // if (!mounted) return;
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Etablissement()));
                        afficherAlert();
                          } else {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Erreur',
                              text: 'Ajouter Les informations necessaires', 
                            );
                          }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        padding: isLoading
                            ? MaterialStateProperty.all(
                                const EdgeInsets.all(9))
                            : MaterialStateProperty.all(
                                const EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      child: isLoading
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: whiteColor,
                                size: 32,
                              ),
                            )
                          : const Text(
                              "Ajouter une Faculté",
                              style:
                                  TextStyle(fontSize: 13, color: whiteColor),
                            ))),
            ],
          ),
          const Gap(10),
        ],
      ),
    ),
          )),
        );
  }
}
