import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orientation_app/actualite/acceuilcard.dart';
import 'package:orientation_app/actualite/ajouteractualite.dart';
import 'package:orientation_app/actualite/skeltoncard.dart';
import 'package:orientation_app/lyceeScreens/notifications/notifications.dart';
import 'package:orientation_app/lyceeScreens/questionScreens/questionhome.dart';
import 'package:orientation_app/lyceeScreens/economieScreens/ecogestion.dart';
import 'package:orientation_app/lyceeScreens/informatiqueScreens/informatique.dart';
import 'package:orientation_app/lyceeScreens/lettresScreens/lettres.dart';
import 'package:orientation_app/lyceeScreens/sciencesScreens/home.dart';
import 'package:orientation_app/robot/robot.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/bourses/bourseshome.dart';
import 'package:orientation_app/userScreens/contact/contact.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementHome.dart';
import 'package:orientation_app/userScreens/evenement/evenementhome.dart';
import 'package:orientation_app/userScreens/experinece/experiencehome.dart';
import 'package:orientation_app/userScreens/formation/formationhome.dart';
import 'package:orientation_app/userScreens/profile/profile.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';

import '../userScreens/contact/reclamations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _allResult = [];
  getJobsStream() async {
    var data = await FirebaseFirestore.instance
        .collection('actualite')
        // .orderBy('faculte')
        .get();

    setState(() {
      _allResult = data.docs;
    });
    // searchResultList();
  }

  @override
  void didChangeDependencies() {
    getJobsStream();
    super.didChangeDependencies();
  }

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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
           appBar: AppBar(
                centerTitle: true,
                title: const Row(
                  children: [
                    SizedBox(
                      width: 55,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Page d'acceuil",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                leading: Builder(
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Iconsax.user,
                          color: blackColor,
                        )),
                  ),
                ),
              ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal:7.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.15,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5),
                itemCount: 8,
                itemBuilder: (context, index){
                  return const SkeltonCard();
                }),
            ),
          )
        : Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Row(
              children: [
                SizedBox(
                  width: 55,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Page d'acceuil",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
                )
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
                                        Get.to(() => const HomeScience(),
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
                                        Get.to(
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
                                        Get.to(() => const LettresScreen(),
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
                                        Get.to(
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
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 15),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.15,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10),
              itemCount: _allResult.length,
              itemBuilder: ((context, index) {
                return AcceuilCard(
                    firstImageLink: _allResult[index]['imgLink'],
                    firstTitle: _allResult[index]["actualiteTitre"]);
              }),
            ),
          ),
        );
  }
}
