import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:orientation_app/shared/addavistfield.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';

import '../../userScreens/bourses/boursebutton.dart';

class AddAvis extends StatefulWidget {
  const AddAvis({super.key});

  @override
  State<AddAvis> createState() => _AddAvisState();
}

class _AddAvisState extends State<AddAvis> {
  TextEditingController nomController = TextEditingController();
   TextEditingController etablissmentController = TextEditingController();
  TextEditingController niveauEtudeController = TextEditingController();
  TextEditingController questionController = TextEditingController();
    
   getToken() async {
    String? mytoken = await FirebaseMessaging.instance.getToken();
    print("============================================");
    print(mytoken);
    return mytoken;
  }

   ajouterQuestion() async {
    String myNotifToken = await getToken();
    String newId = const Uuid().v1();
    try {
      FirebaseFirestore.instance.collection('posts').doc(newId).set({
        "post_id": newId,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "token": myNotifToken,
        'nom':nomController.text, 
        'etablissment' : etablissmentController.text,
        'niveau' : niveauEtudeController.text,
        'question' : questionController.text,
      });
    } catch (e) {
      // print(e);
    }
  } 
      afficherAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Question ajouter avec succes!',
        onConfirmBtnTap: () {
          nomController.clear();
          etablissmentController.clear();
          niveauEtudeController.clear();
          questionController.clear();
          Navigator.of(context).pop();
        });
  }

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
    Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const  Gap(20),
           
              //  Align(
              //       alignment: Alignment.topLeft,
              //       child: InkWell(
              //         onTap: () {
              //           Navigator.of(context).pop();
              //         },
              //         child: const Icon(
              //           Icons.arrow_back,
              //           color: mainColor,
              //         ),
              //       ),
              //     ),
                    const  Gap(20),
          AddAvisTField(title: "Nom et Prénom", text: "Enter votre nom", controller: nomController, 
                        validator: (value) {
                      return value!.isEmpty ? "ne peut être vide" : null;
                    },), 
         const  Gap(20),
          AddAvisTField(title: "Nom de l'etablissement", text: "Enter nom de l'etablissment", controller: etablissmentController, 
                        validator: (value) {
                      return value!.isEmpty ? "ne peut être vide" : null;
                    },), 
         const  Gap(20),
           AddAvisTField(title: "Niveau d'etude", text: "Enter votre niveau", controller: niveauEtudeController, 
                        validator: (value) {
                      return value!.isEmpty ? "ne peut être vide" : null;
                    },), 
          const Gap(20),
           const Text("Question", style:   TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
           const Gap(10),
          SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.9, // <-- TextField width
                height: 180, // <-- TextField height
                child: TextField(
                  controller: questionController,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: "Entrer votre question",
                    hintStyle: const TextStyle(color: Colors.black87),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: Colors.black54,
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
              )
            ,const Gap(20),
             Row(
               children: [
                 Expanded(
                  child: BourseButton(onPressed: ()async{
                    await ajouterQuestion();
                    afficherAlert();
                  }, textButton: " Ajouter Votre question")),
               ],
             ),
            const  Gap(20)
            ]
          ),
        ),
      ),
    ));
  }
}