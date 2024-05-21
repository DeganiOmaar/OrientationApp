// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/actualite/homescreen.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:get/get.dart';
import '../../shared/colors.dart';
import 'registartiontextfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  String? selectedRole ; 
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;
  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "nom": nomController.text,
        "prenom": prenomController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": selectedRole,
        'adress':"", 
        'emplacement':"",
        'anniversaire':"",
        'universite':"",
        'telephone':"",
        "uid": FirebaseAuth.instance.currentUser!.uid,
      });
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erreur...',
          text: 'mot de passe faible!',
        );
      } else if (e.code == 'email-already-in-use') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Erreur...',
          text: 'utilisateur existe!',
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Vérifiez votre e-mail ou votre mot de passe!',
      );
       setState(() {
      isLoading = false;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Inscription",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                 "Rejoignez notre communauté en quelques étapes simples.",
                  style: TextStyle(color: Colors.grey)),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: RegistrationTextField(
                      icon: CupertinoIcons.person,
                      text: "  Nom",
                      controller: nomController,
                        validator: (value) {
                  return value!.isEmpty ? "Entrez un nom valide" : null;
                },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: RegistrationTextField(
                      icon: CupertinoIcons.person,
                      text: "Prenon",
                      controller: prenomController,
                        validator: (value) {
                  return value!.isEmpty ? "Entrez un prenom valide" : null;
                },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              RegistrationTextField(
                icon: CupertinoIcons.mail,
                text: "  Email",
                controller: emailController,
                  validator: (email) {
                  return email!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Entrez un email valide";
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                    color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Center(
                  child: DropdownButton<String>(
                    value: selectedRole,
                    icon: const Icon(Icons.arrow_downward,color: Colors.black26,),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: blackColor, fontSize: 17),
                    onChanged: (newValue) {
                      setState(() {
                        selectedRole = newValue!;
                      });
                    },
                    hint: const Text('ajouter votre role',style: TextStyle(color: Colors.black26, fontSize: 16),),
                    underline: Container(),
                    items: <String>['1/2 année', 'baccalauréat/licence', 'société', ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
                TextFormField(
                    validator: (value) {
                  return value!.isEmpty
                      ? "Entrer au moins 6 caractères"
                      : null;
                },
                obscureText: isPasswordVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: isPasswordVisible
                          ? const Icon(
                              CupertinoIcons.eye,
                              color: greyColor,
                              size: 22,
                            )
                          : const Icon(
                              CupertinoIcons.eye_slash,
                              color: greyColor,
                              size: 22,
                            )),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      top: 2.0,
                      left: 3.0,
                    ),
                    child: Icon(
                      CupertinoIcons.lock_rotation_open,
                      color: greyColor,
                      size: 22,
                    ),
                  ),
                  hintText: "Mot de passe",
                  hintStyle:
                      const TextStyle(color: Colors.black26, fontSize: 16),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            
              const SizedBox(
                height: 30,
              ),
                TextFormField(
                    validator: (value) {
                  return value!.isEmpty
                      ? "Entrer au moins 6 caractères"
                      : null;
                },
                obscureText: isPasswordVisible,
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: isPasswordVisible
                          ? const Icon(
                              CupertinoIcons.eye,
                              color: greyColor,
                              size: 22,
                            )
                          : const Icon(
                              CupertinoIcons.eye_slash,
                              color: greyColor,
                              size: 22,
                            )),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      top: 2.0,
                      left: 3.0,
                    ),
                    child: Icon(
                      CupertinoIcons.lock_rotation_open,
                      color: greyColor,
                      size: 22,
                    ),
                  ),
                  hintText: "Confirmer mot de passe",
                  hintStyle:
                      const TextStyle(color: Colors.black26, fontSize: 16),
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Mot de passe oublie?",
                      style: TextStyle(color: greyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                              if (formstate.currentState!.validate()) {
                      await register();
                    } else {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Erreur',
                        text: 'Ajoutez vos informations',
                      );
                    }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(mainColor),
                            padding: isLoading
                                ? MaterialStateProperty.all(
                                    const EdgeInsets.all(10))
                                : MaterialStateProperty.all(
                                    const EdgeInsets.all(13)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
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
                                  "Enregistrer",
                                  style: TextStyle(
                                      fontSize: 16, color: whiteColor),
                                ))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  "Vous avez un compte?",
                  style: TextStyle(color: greyColor),
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LoginPage()));
    
                                Get.off( () => const LoginPage(), transition: Transition.upToDown);
                    },
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(color: mainColor),
                    ))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
