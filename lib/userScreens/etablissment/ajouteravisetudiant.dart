import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementHome.dart';
import 'package:uuid/uuid.dart';

import '../../shared/colors.dart';

class AjouterAvisEtudiant extends StatefulWidget {
  final String faculteid;
  final String userid;
  const AjouterAvisEtudiant({super.key, required this.faculteid, required this.userid});

  @override
  State<AjouterAvisEtudiant> createState() => _AjouterAvisEtudiantState();
}

class _AjouterAvisEtudiantState extends State<AjouterAvisEtudiant> {
  TextEditingController nomController = TextEditingController();
  TextEditingController avisController = TextEditingController();
  bool isLoading = false;

  ajouterAvis() async {
    setState(() {
      isLoading = true;
    });

    try {
      CollectionReference avis = FirebaseFirestore.instance
          .collection('etablissment')
          .doc(widget.faculteid)
          .collection("AvisEtudiants");
      String newId = const Uuid().v1();
      avis.doc(newId).set({
        'userid' : widget.userid,
        'avisid': newId,
        'nom': nomController.text, // John Doe
        'avis': avisController.text // 42
      });
    } catch (err) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ajouter un Avis",
          style: TextStyle(
              fontSize: 17, color: blackColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Gap(20),
          const Gap(10),
          AddAvisTField(
            title: 'Ajouter Votre Nom et Prenom',
            text: 'Prenom',
            controller: nomController,
            validator: (value) {
              return value!.isEmpty ? "ne peut être vide" : null;
            },
          ),
          const Gap(20),
          const Text("Ajouter votre Avis",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const Gap(20),
          SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.9, // <-- TextField width
            height: 180, // <-- TextField height
            child: TextField(
              controller: avisController,
              maxLines: null,
              expands: true,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: "Entrer votre avis",
                hintStyle: const TextStyle(color: Colors.black26),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 220, 220, 220),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 220, 220, 220),
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        await ajouterAvis();
                        Get.off(()=>const Etablissement());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(mainColor),
                        padding: isLoading
                            ? MaterialStateProperty.all(const EdgeInsets.all(9))
                            : MaterialStateProperty.all(
                                const EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
                              "Ajouter un Avis",
                              style: TextStyle(fontSize: 13, color: whiteColor),
                            ))),
            ],
          ),
          const Gap(10),
        ]),
      ),
    ));
  }
}
