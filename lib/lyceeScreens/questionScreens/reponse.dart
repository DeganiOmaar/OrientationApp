import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/lyceeScreens/questionScreens/questioncard.dart';
import 'package:orientation_app/lyceeScreens/questionScreens/replycard.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Reponse extends StatefulWidget {
  final String nom;
  final String niveau;
  final String etablissement;
  final String question;
  final String postId;
  final String userPublishedId;
  final String myToken;
  const Reponse(
      {super.key,
      required this.nom,
      required this.niveau,
      required this.etablissement,
      required this.question,
      required this.postId,
      required this.userPublishedId,
      required this.myToken});

  @override
  State<Reponse> createState() => _ReponseState();
}

class _ReponseState extends State<Reponse> {
  TextEditingController reponseController = TextEditingController();

  Map userData = {};
  bool isLoading = true;

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      userData = snapshot.data()!;
    } catch (e) {
      // print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  ajouterReponse() async {
    // String myNotifToken = await getToken();
    String newId = const Uuid().v1();
    try {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('reponse')
          .doc(newId)
          .set({
        'nom': userData['nom'].substring(0, 1).toUpperCase() +
            userData['nom'].substring(1) +
            " " +
            userData['prenom'].substring(0, 1).toUpperCase() +
            userData['prenom'].substring(1),
        "post_id": widget.postId,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        'post_user_id': widget.userPublishedId,
         'reponse_date' : DateTime.now(),
        "token": widget.myToken,
        'reponse': reponseController.text,
      });
      // reponseController.clear();
    } catch (e) {
      // print(e);
    }
  }

  sendNotif() async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAA_v2Iu4c:APA91bE3fzCuUt5Nr1BSHzbJoHDo9iDBFZAASOHegmZ8_1kFKIH-qME23Yof5AY_6NlHnCllhnj6CIjNEVCUPesD-y24owe_lnclQJMlkpj10UxsJECP0EWe4pEf5lYKgctHnDu1GwWx'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": widget.myToken,
      "notification": {
        "title": userData['nom'].substring(0, 1).toUpperCase() +
            userData['nom'].substring(1) +
            " " +
            userData['prenom'].substring(0, 1).toUpperCase() +
            userData['prenom'].substring(1) +
            " a repondu",
        "body": reponseController.text
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  ajouterNotifBD() async {
    String newNotifId = const Uuid().v1();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userPublishedId)
        .collection("notifications")
        .doc(newNotifId)
        .set({
      'notifId': newNotifId,
      'nom': userData['nom'].substring(0, 1).toUpperCase() +
          userData['nom'].substring(1) +
          " " +
          userData['prenom'].substring(0, 1).toUpperCase() +
          userData['prenom'].substring(1),
      'reponse': reponseController.text,
      'reponse_date' : DateTime.now(),
      'token': widget.myToken,
      'reponseUserId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            backgroundColor: whiteColor,
            body: Center(
              child: LoadingAnimationWidget.discreteCircle(
                  size: 32,
                  color: const Color.fromARGB(255, 16, 16, 16),
                  secondRingColor: Colors.indigo,
                  thirdRingColor: Colors.pink.shade400),
            ),
          )
        : Scaffold(
          appBar: AppBar(
              centerTitle: true,
          title: const Text(
            "Les Réponses",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: blackColor),
          ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                // Gap(10),
                QuestionCard(
                    nom: widget.nom,
                    niveau: widget.niveau,
                    etablissement: widget.etablissement,
                    question: widget.question),
                const Gap(10),
                Divider(thickness: 1, color: Colors.grey.shade500),
                const Gap(20),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.postId)
                        .collection('reponse')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
        
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: LoadingAnimationWidget.discreteCircle(
                              size: 32,
                              color: const Color.fromARGB(255, 16, 16, 16),
                              secondRingColor: Colors.indigo,
                              thirdRingColor: Colors.pink.shade400),
                        );
                      }
        
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return ReplyCard(
                            reponseNom: data['nom'],
                            reponse: data['reponse'],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
        
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                            controller: reponseController,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(
                                // To delete borders
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: backgroundgreyColor,
                                  ),
                                ),
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                // contentPadding: const EdgeInsets.all(2),
                                hintText: "Répondre au question",
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    if (reponseController.text.isNotEmpty) {
                                      await ajouterReponse();
                                    if(FirebaseAuth.instance.currentUser!.uid != widget.userPublishedId){
                                        sendNotif();
                                      ajouterNotifBD();
                                    }
                                      reponseController.clear();
                                      setState(() {});
                                    } else {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.error,
                                        title: 'Erreur',
                                        text: 'Entrez votre reponse',
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                      FontAwesomeIcons.paperPlane),
                                ))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }
}
