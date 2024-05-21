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


class AddActualite extends StatefulWidget {
  const AddActualite({super.key});

  @override
  State<AddActualite> createState() => _AddActualiteState();
}

class _AddActualiteState extends State<AddActualite> {
  TextEditingController actualiteTitreController = TextEditingController();
  TextEditingController actualiteContenuController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

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

  ajouterNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      final storageRef = FirebaseStorage.instance.ref("$imgName");
      await storageRef.putFile(imgPath!);
      String urll = await storageRef.getDownloadURL();

      CollectionReference course =
          FirebaseFirestore.instance.collection('actualite');
      String newId = const Uuid().v1();
      course.doc(newId).set({
        'actualite_id' : newId,
        "imgLink": urll,
        "actualiteTitre": actualiteTitreController.text,
        "actualiteContenu": actualiteContenuController.text,
        
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
        text: 'Actualite ajouter avec succes!',
        onConfirmBtnTap: () {
          actualiteContenuController.clear();
          actualiteTitreController.clear();
          Navigator.of(context).pop();
        });
  } 
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
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
                                  AssetImage("assets/images/news.jpg"),
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
                    title: 'Titre de l\'actualité',
                    text: 'Ajouter un titre',
                    controller: actualiteTitreController, 
                      validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },),
                const Gap(10),
                AddAvisTField(
                    title: 'Contenue de l\'actualité',
                    text: 'Nom de la société',
                    controller: actualiteContenuController, 
                      validator: (value) {
                    return value!.isEmpty ? "ne peut être vide" : null;
                  },),
               Spacer(),
                 Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                            
                                  if (formstate.currentState!.validate()) {
                                 await ajouterNews();
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
                                    "Ajouter actualite",
                                    style: TextStyle(
                                        fontSize: 13, color: whiteColor),
                                  ))),
                  ],
                ),
                const Gap(10),
            ],
          ),
        ),
      )
    )
    );
  }
}