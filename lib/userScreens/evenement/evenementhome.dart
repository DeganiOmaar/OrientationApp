import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/actualite/ajouteractualite.dart';
import 'package:orientation_app/actualite/homescreen.dart';
import 'package:orientation_app/lyceeScreens/economieScreens/ecogestion.dart';
import 'package:orientation_app/lyceeScreens/informatiqueScreens/informatique.dart';
import 'package:orientation_app/lyceeScreens/lettresScreens/lettres.dart';
import 'package:orientation_app/lyceeScreens/notifications/notifications.dart';
import 'package:orientation_app/lyceeScreens/questionScreens/questionhome.dart';
import 'package:orientation_app/lyceeScreens/sciencesScreens/home.dart';
import 'package:orientation_app/robot/robot.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/bourses/bourseshome.dart';
import 'package:orientation_app/userScreens/contact/contact.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementHome.dart';
import 'package:orientation_app/userScreens/evenement/addevents.dart';
import 'package:orientation_app/userScreens/evenement/eventcard.dart';
import 'package:orientation_app/userScreens/experinece/experiencehome.dart';
import 'package:orientation_app/userScreens/formation/formationhome.dart';
import 'package:orientation_app/userScreens/profile/profile.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';

import '../contact/reclamations.dart';

class Evenement extends StatefulWidget {
  const Evenement({super.key});

  @override
  State<Evenement> createState() => _EvenementState();
}

class _EvenementState extends State<Evenement> {
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

        : Scaffold(
              backgroundColor: backgroundgreyColor,
          appBar: AppBar(
              actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AjouterEvenement()));
              },
              child: const Icon(CupertinoIcons.add_circled, color: blackColor)),
          const Gap(10)
        ],
            centerTitle: true,
            title: const Row(
              children: [
                SizedBox(
                  width: 65,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Evénements",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                ), 
                    
              ],
            ),
            backgroundColor: Colors.white,
            leading: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: blackColor,
                  )),
            ),
           
          ),
          drawer: SizedBox(
            // width: MediaQuery.of(context).size.width,
            child: Drawer(
                backgroundColor: mainColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: blackColor,
                                ),
                              )),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12),
                                    elevation: 0,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.5),
                                    foregroundColor: Colors.black,
                                    side: const BorderSide(
                                      width: 1.0,
                                      color: mainColor,
                                    )),
                                child: const Text(
                                  ' Aide ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          userData['nom'].substring(0, 1).toUpperCase() +
                              userData['nom'].substring(1) +
                              " " +
                              userData['prenom']
                                  .substring(0, 1)
                                  .toUpperCase() +
                              userData['prenom'].substring(1),
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: whiteColor),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: whiteColor,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              const Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  "Bienvenue à...",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                      title: const Text(
                                        "Page d'accueil",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/accueil.svg',
                                        height: 25.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const HomeScreen(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                                   const  SizedBox(height: 30,),
                              userData['role'] == "1/2 année"
                                  ? ListTile(
                                      title: const Text(
                                        "Section Sciences ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/direction.svg',
                                        height: 30.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const HomeScience(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : ListTile(
                                      title: const Text(
                                        "Etablissments",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/education.svg',
                                        height: 25.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Etablissement(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              userData['role'] == "1/2 année"
                                  ? ListTile(
                                      title: const Text(
                                        "Section Economie/Gestion ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/direction.svg',
                                        height: 30.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(
                                            () => const EcoGestionScreen(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : ListTile(
                                      title: const Text(
                                        "Formations",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/formation.svg',
                                        height: 25.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Formation(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              userData['role'] == "1/2 année"
                                  ? ListTile(
                                      title: const Text(
                                        "Section Lettres/Langues ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/direction.svg',
                                        height: 30.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const LettresScreen(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : ListTile(
                                      title: const Text(
                                        "Bourses",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/bourse.svg',
                                        height: 25.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Bourses(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              userData['role'] == "1/2 année"
                                  ? ListTile(
                                      title: const Text(
                                        "Section Informatiques ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/direction.svg',
                                        height: 30.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(
                                            () =>
                                                const InformatiqueScreen(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : ListTile(
                                      title: const Text(
                                        "Experiences",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/works.svg',
                                        height: 30.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Experience(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              userData['role'] == "1/2 année"
                                  ? ListTile(
                                      title: const Text(
                                        "Questions des Élèves ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/ask2.svg',
                                        height: 40.0,
                                        width: 50.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const AvisHome(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : ListTile(
                                      title: const Text(
                                        "Evennements",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/event.svg',
                                        height: 25.0,
                                        width: 60.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Evenement(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                              userData['role'] == "1/2 année"
                                  ? Container()
                                  : userData['role'] == "admin"
                                      ? Container()
                                      : const SizedBox(
                                          height: 20,
                                        ),
                              userData['role'] == "1/2 année"
                                  ? Container()
                                  : userData['role'] == "admin"
                                      ? Container()
                                      : ListTile(
                                          title: const Text(
                                            "Questions ",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600),
                                          ),
                                          leading: SvgPicture.asset(
                                            'assets/images/ask2.svg',
                                            height: 40.0,
                                            width: 40.0,
                                            allowDrawingOutsideViewBox:
                                                true,
                                          ),
                                          onTap: () {
                                            Get.off(() => const AvisHome(),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                        ),
                              const SizedBox(
                                height: 20,
                              ),
                              userData['role'] == "admin"
                                  ? ListTile(
                                      title: const Text(
                                        "Reclamations",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/ask2.svg',
                                        height: 40.0,
                                        width: 40.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Reclamation(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : ListTile(
                                      title: const Text(
                                        "Questionner le robot ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/ask2.svg',
                                        height: 40.0,
                                        width: 70.0,
                                        // allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(() => const Robot(),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    ),
                              userData['role'] == "1/2 année"
                                  ? const SizedBox(
                                      height: 20,
                                    )
                                  : Container(),
                              userData['role'] == "admin"
                                  ? const SizedBox(
                                          height: 20,
                                        )
                                  : userData['role'] == "1/2 année"
                                      ? Container()
                                      : const SizedBox(
                                          height: 20,
                                        ),
                              userData['role'] == "1/2 année"
                                  ? Container()
                                  : userData['role'] == "admin"
                                      ? Container()
                                      : ListTile(
                                          title: const Text(
                                            "Notifications ",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600),
                                          ),
                                          leading: SvgPicture.asset(
                                            'assets/images/notification.svg',
                                            height: 30.0,
                                            width: 70.0,
                                            allowDrawingOutsideViewBox:
                                                true,
                                          ),
                                          onTap: () {
                                            Get.off(
                                                () => Notifications(
                                                      uid: userData['uid'],
                                                    ),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                        ),
                              userData['role'] == "admin"
                                  ? Container()
                                  : userData['role'] == "1/2 année"
                                      ? Container()
                                      : const SizedBox(
                                          height: 20,
                                        ),
                              userData['role'] == "1/2 année"
                                  ? ListTile(
                                      title: const Text(
                                        "Notifications ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      leading: SvgPicture.asset(
                                        'assets/images/notification.svg',
                                        height: 30.0,
                                        width: 70.0,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                      onTap: () {
                                        Get.off(
                                            () => Notifications(
                                                  uid: userData['uid'],
                                                ),
                                            transition:
                                                Transition.rightToLeft);
                                      },
                                    )
                                  : userData['role'] == "admin"
                                      ? ListTile(
                                          title: const Text(
                                            "Ajouter Actualité",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600),
                                          ),
                                          leading: SvgPicture.asset(
                                            'assets/images/add.svg',
                                            height: 25.0,
                                            width: 70.0,
                                            allowDrawingOutsideViewBox:
                                                true,
                                          ),
                                          onTap: () {
                                            Get.off(
                                                () => const AddActualite(),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                        )
                                      : ListTile(
                                          title: const Text(
                                            "Contact",
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600),
                                          ),
                                          leading: SvgPicture.asset(
                                            'assets/images/typing.svg',
                                            height: 40.0,
                                            width: 70.0,
                                            allowDrawingOutsideViewBox:
                                                true,
                                          ),
                                          onTap: () {
                                            Get.off(() => const Contact(),
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                        ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                title: const Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/images/profile.svg',
                                  height: 30.0,
                                  width: 70.0,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                onTap: () {
                                  Get.off(() => const Profile(),
                                      transition: Transition.rightToLeft);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                title: const Text(
                                  "Déconnecter",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/images/logout.svg',
                                  height: 25.0,
                                  width: 70.0,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  if (!mounted) return;
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) => false);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ]),
                      )
                    ],
                  ),
                )),
          ),
              
              body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Prochains Evénements",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: blackColor),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Explorez nnotre calendrier d’évenements a venir et prépare-vous a vous immegrer dans des opportunités enrichissantes qui enchiront votre parcours académiques et proffessionnel",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w700, color: greyColor),
              // textAlign: TextAlign.justify,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('evenements')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
        
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                          size: 32,
                          color: const Color.fromARGB(255, 16, 16, 16),
                          secondRingColor: Colors.indigo,
                          thirdRingColor: Colors.pink.shade400),
                    );
                  }
        
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return EventCard(
                          imgLink: data['imgLink'],
                          eventday: DateFormat('MMMM d,' 'y')
                              .format(data['startDate'].toDate()),
                          title: data['titre'],
                          eventtime: data['temps'],
                          location: data['localisation'],
                          description: data['description']);
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
              ),
            );
  }
}
