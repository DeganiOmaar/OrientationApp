import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';
import 'second.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.off(() => const LoginPage());
              },
              icon: const Icon(Iconsax.forward))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: AnimatedTextKit(
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        "On n'est jamais trop vieux pour apprendre.",
                        speed: const Duration(milliseconds: 40),
                        textStyle: const TextStyle(
                            fontFamily: "Cera Pro",
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: secondaryColor),
                      )
                    ]),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: AnimatedTextKit(
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        "Le chemin vers nos aspirations est pavé d'obstacles à surmonter pour atteindre le sommet.",
                        speed: const Duration(milliseconds: 40),
                        textStyle: const TextStyle(
                          
                            fontFamily: "Cera Pro",
                            fontWeight: FontWeight.w600,
                            // fontSize: 20,
                             color: Color.fromARGB(255, 170, 170, 170),),
                            //  textAlign: TextAlign.right,
                      )
                    ]),
              ),
              ],
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Image.asset("assets/images/first.png"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(12)),
              child: TextButton(
                onPressed: () {
                  Get.off( () => const SecondPage(), transition: Transition.rightToLeft);
                },
                child: const Text(
                  'Suivant',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
 
  }
}