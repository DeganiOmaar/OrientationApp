import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orientation_app/describeapp/first.dart';
import 'package:orientation_app/describeapp/third.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const  EdgeInsets.only(left: 20.0, right: 20, ),
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
                        "L'éducation est l'arme la plus puissante qu'on puisse utiliser pour changer le monde.",
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
                        "La clé du progrès : investir dans l'éducation pour façonner un monde meilleur.",
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
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Image.asset("assets/images/two.png"),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                      onPressed: () {
                        Get.off(() => const FirstPage(),
                            transition: Transition.leftToRight);
                      },
                      child: const Text(
                        'Retour',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                      onPressed: () {
                        Get.off(() => const ThirdPage(),
                            transition: Transition.rightToLeft);
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
          )
        ],
      ),
    );
  }
}
