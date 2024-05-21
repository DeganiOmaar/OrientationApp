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
import 'package:orientation_app/shared/colors.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show basename;

class AjouterEvenement extends StatefulWidget {
  const AjouterEvenement({super.key});

  @override
  State<AjouterEvenement> createState() => _AjouterEvenementState();
}

class _AjouterEvenementState extends State<AjouterEvenement> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController titreController = TextEditingController();
  TextEditingController tempsController = TextEditingController();
  TextEditingController localisationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now();
  bool isPicking = false;
  // bool isPicking2 = false;
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

  ajouterUnEvenement() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref("$imgName");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      CollectionReference course =
          FirebaseFirestore.instance.collection('evenements');
      String newId = const Uuid().v1();
      course.doc(newId).set({
        'post_id' : newId,
        'uid': FirebaseAuth.instance.currentUser!.uid,
        "imgLink": urll,
        'titre': titreController.text,
        'temps': tempsController.text,
        'localisation': localisationController.text,
        'description': descriptionController.text,
        'startDate': startDate
        
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
          titreController.clear();
          tempsController.clear();
          localisationController.clear();
          descriptionController.clear();
          imgPath = null;
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
      "Ajouter un evenement",
      style: TextStyle(
          fontSize: 17, color: blackColor, fontWeight: FontWeight.w700),
    ),
          ),
          body: Padding(
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
                            AssetImage("assets/images/event2.jpg"),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Evenement commence le :",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? newStartDate = await showDatePicker(
                            context: context,
                            initialDate: startDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (newStartDate == null) return;
            
                        setState(() {
                          isPicking = true;
                          startDate = newStartDate;
                        });
                      },
                      child: Container(
                          // filled: true,
          
                        height: 48,
                        // width: MediaQuery.sizeOf(context).width * 0.43,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: blackColor, width: 0.1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: isPicking
                                ? Text(
                                    "${startDate.day}/${startDate.month}/${startDate.year}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )
                                : const Text("")),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(10),
          AddAvisTField(
              title: 'Titre',
              text: 'Titre de l\'evenement',
              controller: titreController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
          AddAvisTField(
              title: 'Localisation',
              text: 'Ajouter la localisation',
              controller: localisationController, 
                  validator: (value) {
                return value!.isEmpty ? "ne peut être vide" : null;
              },),
          const Gap(10),
             AddAvisTField(
              title: 'Temps de l\'evenement',
              text: '8:30 AM - 10:30 PM',
              controller: tempsController, 
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
          const Spacer(),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                   
                            if (formstate.currentState!.validate()) {
                          await ajouterUnEvenement();
                        // if (!mounted) return;
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Evenement()));
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
                              "Ajouter un evenement",
                              style:
                                  TextStyle(fontSize: 13, color: whiteColor),
                            ))),
            ],
          ),
          const Gap(10),
        ],
      ),
    ),
          ),
        );
  }
}
