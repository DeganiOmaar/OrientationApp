import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' show basename;

import '../../shared/colors.dart';

class AjouterExperience extends StatefulWidget {
  const AjouterExperience({super.key});

  @override
  State<AjouterExperience> createState() => _AjouterExperienceState();
}

class _AjouterExperienceState extends State<AjouterExperience> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController filiereController = TextEditingController();
  TextEditingController localisationController = TextEditingController();
  TextEditingController niveauController = TextEditingController();
  TextEditingController faculteController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController gitHubController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
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

  ajouterUneExperience() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("$imgName");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      CollectionReference course =
          FirebaseFirestore.instance.collection('experiences');
      String newId = const Uuid().v1();
      course.doc(newId).set({
        "imgLink": urll,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'nom': nomController.text,
        'filiere': filiereController.text,
        'localisation': localisationController.text,
        'niveau': niveauController.text,
        'faculte': faculteController.text,
        'description': descriptionController.text,
        'facebook': facebookController.text,
        'gitHub': gitHubController.text,
        'linkedin': linkedinController.text,
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
        text: 'Experience ajouter avec succes!',
        onConfirmBtnTap: () {
          nomController.clear();
          filiereController.clear();
          localisationController.clear();
          niveauController.clear();
          faculteController.clear();
          descriptionController.clear();
          facebookController.clear();
          gitHubController.clear();
          linkedinController.clear();
          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
    centerTitle: true,
    title: const Text(
      "Ajouter une experience",
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
                          backgroundColor:
                              Color.fromARGB(255, 225, 225, 225),
                          radius: 55,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
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
              title: 'Nom et Prenom',
              text: 'Ajouter votre nom et prenom ',
              controller: nomController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Filiere',
              text: 'Ajouter votre filere ',
              controller: filiereController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Localisation',
              text: 'Ajouter votre localisation ',
              controller: localisationController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Niveau d\'etude',
              text: 'Ajouter votre niveau d\'etude ',
              controller: niveauController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Nom de la faculté',
              text: 'Ajouter votre faculté',
              controller: faculteController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Description',
              text: 'Ajouter une Description',
              controller: descriptionController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Facebook',
              text: 'Ajouter le lien de votre facebook',
              controller: facebookController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Linkedin',
              text: 'Ajouter le lien de votre linkedin',
              controller: linkedinController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),
            const Gap(10),
            AddAvisTField(
              title: 'Github',
              text: 'Ajouter le lien de votre github',
              controller: gitHubController,
              validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },
            ),

            const Gap(20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          if (formstate.currentState!.validate()) {
                            await ajouterUneExperience();
                            afficherAlert();
                            setState(() {
                              
                            });
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
                          backgroundColor:
                              MaterialStateProperty.all(mainColor),
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
                                child: LoadingAnimationWidget
                                    .staggeredDotsWave(
                                  color: whiteColor,
                                  size: 32,
                                ),
                              )
                            : const Text(
                                "Ajouter une experience",
                                style: TextStyle(
                                    fontSize: 15, color: whiteColor),
                              ))),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    ),
          ),
        );
  }
}
