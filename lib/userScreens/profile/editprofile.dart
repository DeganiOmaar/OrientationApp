import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/userScreens/profile/priflebutton.dart';
import 'package:orientation_app/userScreens/profile/profilepage.dart';
import 'package:orientation_app/userScreens/profile/profiletextfield.dart';
import '../../shared/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
      print(e.toString());
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

  DateTime startDate = DateTime.now();
  bool isPicking = false;
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emplacementController = TextEditingController();
  TextEditingController universiteController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();

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
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundgreyColor,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                'assets/images/profilepic.svg',
                height: 120.0,
                width: 120.0,
                allowDrawingOutsideViewBox: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                      child: ProfileTextField(
                    title: "Nom",
                    text: userData['nom'] == ""
                        ? "Entrer votre nom"
                        : userData['nom'].substring(0, 1).toUpperCase() +
                            userData['nom'].substring(1),
                    controller: nomController,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ProfileTextField(
                    title: "Prénom",
                    text: userData['prenom'] == ""
                        ? "Entrer votre prenom"
                        : userData['prenom'].substring(0, 1).toUpperCase() +
                            userData['prenom'].substring(1),
                    controller: prenomController,
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ProfileTextField(
                    title: "Email",
                    text: userData['email'] == ""
                        ? "Entrer votre email"
                        : userData['email'],
                    controller: emailController,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ProfileTextField(
                    title: "Adress",
                    text: userData['adress'] == ""
                        ? "Entrer votre adress"
                        : userData['adress'],
                    controller: adressController,
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ProfileTextField(
                    title: "Emplacement",
                    text: userData['emplacement'] == ""
                        ? "Entrer votre emplacement"
                        : userData['emplacement'],
                    controller: emplacementController,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  userData['anniversaire'] == ""
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Anniversaire :",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? newStartDate =
                                      await showDatePicker(
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
                                      border: Border.all(
                                          color: blackColor, width: 0.1),
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  child: Center(
                                      child: isPicking
                                          ? Text(
                                              "${startDate.day}/${startDate.month}/${startDate.year}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w700),
                                            )
                                          : const Text("")),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: ProfileTextField(
                          title: "Anniversaire",
                          text: userData['anniversaire'],
                          controller: emailController,
                        )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ProfileTextField(
                    title: "Université/College",
                    text: userData['universite'] == ""
                        ? "Entrer votre université"
                        : userData['universite'],
                    controller: universiteController,
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ProfileTextField(
                    title: "Téléphone",
                    text: userData['telephone'] == ""
                        ? "Entrer votre téléphone"
                        : userData['telephone'],
                    controller: telephoneController,
                  )),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                      child: ProfileButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              "nom": nomController.text == ""
                                  ? userData['nom']
                                  : nomController.text,
                              "prenom": prenomController.text == ""
                                  ? userData['prenom']
                                  : prenomController.text,
                              "email": emailController.text == ""
                                  ? userData['email']
                                  : emailController.text,
                              "adress": adressController.text == ""
                                  ? userData['adress']
                                  : adressController.text,
                              "emplacement":
                                  emplacementController.text == ""
                                      ? userData['emplacement']
                                      : emplacementController.text,
                              "universite": universiteController.text == ""
                                  ? userData['universite']
                                  : universiteController.text,
                              "telephone": telephoneController.text == ""
                                  ? userData['telephone']
                                  : telephoneController.text,
                              "anniversaire": DateFormat('MMMM d,' 'y')
                                          .format(startDate) ==
                                      "null"
                                  ? userData['anniversaire']
                                  : DateFormat('MMMM d,' 'y')
                                      .format(startDate),
                            });
                            setState(() {});
                            Get.off(() => const ProfilePage());
                          },
                          textButton: "Mettre à jour votre profil")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
                  );
  }
}
