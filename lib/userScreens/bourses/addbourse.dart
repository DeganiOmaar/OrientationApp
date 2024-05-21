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
import 'package:orientation_app/shared/snackbar.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class AddBourse extends StatefulWidget {
  const AddBourse({super.key});

  @override
  State<AddBourse> createState() => _AddBourseState();
}

class _AddBourseState extends State<AddBourse> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController lienController = TextEditingController();
  TextEditingController titreController = TextEditingController();
  TextEditingController localisationController = TextEditingController();
  TextEditingController niveauController = TextEditingController();
  TextEditingController dureeController = TextEditingController();
  TextEditingController travailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController instututController = TextEditingController();
  TextEditingController exigences1Controller = TextEditingController();
  TextEditingController exigences2Controller = TextEditingController();
  TextEditingController exigences3Controller = TextEditingController();

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
        // print("NO img selected");
      }
    } catch (e) {
      // print("Error => $e");
    }
  }

  ajouterUnBourse() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("$imgName");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      CollectionReference course =
          FirebaseFirestore.instance.collection('bourses');
      String newId = const Uuid().v1();
      course.doc(newId).set({
        // 'role' : "admin",
        'bourse_id' : newId,
        "imgLink": urll == "" ? "assets/images/bourse1.png" : urll,
        "lien": lienController.text,
        "titre": titreController.text,
        "localisation": localisationController.text,
        "niveau": niveauController.text,
        "duree": dureeController.text,
        "travail": travailController.text,
        "description": descriptionController.text,
        "instutut": instututController.text,
        "exigences1":
            exigences1Controller.text == "" ? " " : exigences1Controller.text,
        "exigences2":
            exigences2Controller.text == "" ? " " : exigences2Controller.text,
        "exigences3":
            exigences3Controller.text == "" ? " " : exigences3Controller.text,
      });
    } catch (err) {
      if(!mounted) return;
        showSnackBar(context, "ERROR :  $err ");
    }
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
          lienController.clear();
          titreController.clear();
          localisationController.clear();
          niveauController.clear();
          dureeController.clear();
          travailController.clear();
          descriptionController.clear();
          instututController.clear();
          exigences1Controller.clear();
          exigences2Controller.clear();
          exigences3Controller.clear();
          Navigator.of(context).pop();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
    centerTitle: true,
    title: const Text(
      "Ajouter un Bourse",
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
            Center(
              child: Stack(
                children: [
                  imgPath == null
                      ? const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 225, 225, 225),
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/images/bourse1.png"),
                        )
                      : ClipOval(
                          child: Image.file(
                            imgPath!,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Positioned(
                    left: 65,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () {
                        uploadImage2Screen();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 19,
                      ),
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
              
            AddAvisTField(
                title: "Ajouter le Lien",
                text: 'Ajouter un lien',
                controller: lienController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
                const Gap(10),
            AddAvisTField(
                title: 'Titre',
                text: 'Ajouter un titre',
                controller: titreController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Localisation',
                text: 'Ajouter une localisation',
                controller: localisationController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: "Niveau étude",
                text: 'Ajouter un niveau',
                controller: niveauController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Duree',
                text: 'Ajouter une duree',
                controller: dureeController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Travail',
                text: 'Ajouter le Type de travail',
                controller: travailController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Description',
                text: 'Ajouter une description',
                controller: descriptionController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Institut ',
                text: 'Ajouter  l\'institut',
                controller: instututController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Exigences 1',
                text: 'Ajouter un exigences',
                controller: exigences1Controller, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Exigences 2',
                text: 'Ajouter un exigences',
                controller: exigences2Controller, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Exigences 3',
                text: 'Ajouter un exigences',
                controller: exigences3Controller, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          
    
                              if (formstate.currentState!.validate()) {
                      await ajouterUnBourse();
                          // if (!mounted) return;
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Bourses()));
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
                                child:
                                    LoadingAnimationWidget.staggeredDotsWave(
                                  color: whiteColor,
                                  size: 32,
                                ),
                              )
                            : const Text(
                                "Ajouter une Bourse",
                                style: TextStyle(
                                    fontSize: 13, color: whiteColor),
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
