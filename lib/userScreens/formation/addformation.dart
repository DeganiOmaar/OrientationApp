import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:path/path.dart' show basename;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

class AddFormation extends StatefulWidget {
  final String uid;
  const AddFormation({super.key, required this.uid});

  @override
  State<AddFormation> createState() => _AddFormationState();
}

class _AddFormationState extends State<AddFormation> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController titreController = TextEditingController();
  TextEditingController nomDeLaSocieteController = TextEditingController();
  TextEditingController contenueController = TextEditingController();
  TextEditingController dureeController = TextEditingController();
  TextEditingController certificationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController instructeurController = TextEditingController();
  TextEditingController categorieController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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

  ajouterUneFormation() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("$imgName");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      CollectionReference course =
          FirebaseFirestore.instance.collection('formation');
      String newId = const Uuid().v1();
      course.doc(newId).set({
        'societe_id' : widget.uid,
        'post_id' : newId,
        "imgLink": urll,
        'titre': titreController.text,
        'nomDeLaSociete': nomDeLaSocieteController.text,
        'contenue': contenueController.text,
        'duree': "${dureeController.text} Mois",
        'certification': certificationController.text,
        'type': typeController.text,
        'prix': "${prixController.text} DT",
        'instructeur': instructeurController.text,
        'categorie': categorieController.text,
        'description': descriptionController.text,
        'email': emailController.text,
        'numero': "+216 ${numeroController.text}",
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
        text: 'Formation ajouter avec succes!',
        onConfirmBtnTap: () {
          titreController.clear();
          nomDeLaSocieteController.clear();
          contenueController.clear();
          dureeController.clear();
          certificationController.clear();
          typeController.clear();
          prixController.clear();
          instructeurController.clear();
          categorieController.clear();
          descriptionController.clear();
          emailController.clear();
          numeroController.clear();
          Navigator.of(context).pop();
        });
  }  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
    centerTitle: true,
    title: const Text(
      "Ajouter une formation",
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
                              AssetImage("assets/images/formation.png"),
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
                title: 'Titre de Formation',
                text: 'Ajouter un titre',
                controller: titreController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Nom de la Société',
                text: 'Nom de la société',
                controller: nomDeLaSocieteController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Contenue de Formation',
                text: 'Ajouter une contenue',
                controller: contenueController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Duree de Formation',
                text: 'Ajouter une duree par mois',
                controller: dureeController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Certification de Formation',
                text: 'Certifié ou non ?',
                controller: certificationController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Type de Formation',
                text: 'En Ligne',
                controller: typeController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Prix de formation',
                text: 'Ajouter un prix en DT',
                controller: prixController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Nom de l\'instructeur',
                text: 'Ajouter un instructeur',
                controller: instructeurController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Catégorie de la formation',
                text: 'Ajouter un catégorie',
                controller: categorieController, 
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
                title: 'Email',
                text: 'Ajouter un email',
                controller: emailController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
            const Gap(10),
            AddAvisTField(
                title: 'Téléphone',
                text: 'Ajouter un numero de telephone',
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
                             await ajouterUneFormation();
                          // if (!mounted) return;
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const Formation()));
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
                           padding:  isLoading
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
                                "Ajouter une formation",
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
