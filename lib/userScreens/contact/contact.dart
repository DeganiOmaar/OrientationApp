import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
import 'package:orientation_app/shared/tfield.dart';
import 'package:orientation_app/userScreens/bourses/bourseshome.dart';
import 'package:orientation_app/userScreens/etablissment/etablissementHome.dart';
import 'package:orientation_app/userScreens/evenement/evenementhome.dart';
import 'package:orientation_app/userScreens/experinece/experiencehome.dart';
import 'package:orientation_app/userScreens/formation/formationhome.dart';
import 'package:orientation_app/userScreens/profile/profile.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';

import '../../shared/snackbar.dart';
import 'reclamations.dart';

class Contact extends StatefulWidget {
  
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Map userData = {};
  bool isLoading = true;
  bool isLoadingReclamation = false;

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

    ajouterReclamation() async {
    setState(() {
      isLoadingReclamation = true;
    });

    try {
      CollectionReference reclamations =
          FirebaseFirestore.instance.collection('reclamations');
      String newId = const Uuid().v1();
      reclamations.doc(newId).set({
        'reclamation_id' : newId,
        'fullname' : fullnameController.text,
        'email' : emailController.text,
        'subject' : subjectController.text,
        'message' : messageController.text,
        'reclamation_date' : DateTime.now(),
        
      });
    } catch (err) {
      if(!mounted) return;
        showSnackBar(context, "ERROR :  $err ");
    }
     setState(() {
      isLoadingReclamation = false;
    });
  }

    afficherAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Reclamation ajouter avec succes!',
        onConfirmBtnTap: () {
          fullnameController.clear();
          emailController.clear();
          subjectController.clear();
          messageController.clear();
          Navigator.of(context).pop();
        });
  }

  @override
  void initState() {
    // _searchController.addListener(_onSearchChanged);
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
          ):  Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundgreyColor,
                    appBar: AppBar(
            centerTitle: true,
            title: const Row(
              children: [
                SizedBox(
                  width: 85,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Contact",
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
    child: Stack(
      children: [
        SvgPicture.asset(
      'assets/images/typing.svg',
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height * 0.9,
    ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Bienvenue dans notre espace de contact",
              style: TextStyle(
                  fontSize: 19, fontWeight: FontWeight.bold, color: blackColor),
            ),
            const SizedBox(
              height: 20,
            ),
             CustomTextField(text: "Nom et Prenom", controller: fullnameController,),
            const SizedBox(
              height: 20,
            ),
             CustomTextField(text: "Email", controller: emailController,),
            const SizedBox(
              height: 20,
            ),
             CustomTextField(text: "Sujet", controller: subjectController,),
            const SizedBox(
              height: 20,
            ),
          
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.9, // <-- TextField width
              height: 180, // <-- TextField height
              child: TextField(
                controller: messageController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: "Message",
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  alignLabelWithHint: true, // Ensure hint text stays aligned with content
                ),
              ),
            )
        ,
        const Spacer(),
        Center(
          child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async{
                    await ajouterReclamation();
                     afficherAlert();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: isLoadingReclamation ? Center(
                                child:
                                    LoadingAnimationWidget.staggeredDotsWave(
                                  color: whiteColor,
                                  size: 32,
                                ),
                              ):const  Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
        ),
         const SizedBox(height: 50,), 
          ],
        ),
      ],
    ),
          ),
        );
  }
}
