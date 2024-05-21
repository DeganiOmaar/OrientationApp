import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/userScreens/profile/editprofile.dart';
import 'package:orientation_app/userScreens/profile/priflecard.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';

import '../../shared/colors.dart';
import 'settingcard.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        : SafeArea(
            child: Scaffold(
            backgroundColor: backgroundgreyColor,
            appBar: AppBar(
              backgroundColor: backgroundgreyColor,
              centerTitle: true,
              title: const Text(
                "Profile",
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.w600),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(()=>const EditProfile());
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const EditProfile()));
                    },
                    child:  Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: whiteColor,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['nom'].substring(0, 1).toUpperCase() +
                              userData['nom'].substring(1) +
                              " " +
                              userData['prenom'].substring(0, 1).toUpperCase() +
                              userData['prenom'].substring(1),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "Modifier Votre Prfile",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: greyColor,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          CupertinoIcons.arrow_right_circle,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: greyColor,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black54),
                    ),
                    child: Column(
                      children: [
                        ProfileCard(
                          title: "Nom",
                          text: userData['nom'].substring(0, 1).toUpperCase() +
                              userData['nom'].substring(1) +
                              " " +
                              userData['prenom'].substring(0, 1).toUpperCase() +
                              userData['prenom'].substring(1),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Colors.black54,
                        ),
                        ProfileCard(title: "Email", text: userData['email']),
                        const Divider(
                          thickness: 1,
                          color: Colors.black54,
                        ),
                        ProfileCard(
                            title: "Emplacement",
                            text: userData['emplacement'] == ""
                                ? "Tunisie"
                                : userData['emplacement']),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SettingCard(
                      text: "Obtenir de l'aide",
                      icon: Iconsax.message_question),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const SettingCard(
                      text: 'À propos de nous',
                      icon: Iconsax.info_circle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SettingCard(
                      text: 'Supprimer le compte',
                      icon: Iconsax.profile_delete),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      if (!mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false);
                    },
                    child: const SettingCard(
                        text: 'Déconnecter', icon: Iconsax.logout),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ));
  }
}
