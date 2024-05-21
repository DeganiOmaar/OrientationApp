import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orientation_app/describeapp/second.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/registerscreens/login.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
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
                        "Vivez des sensations fortes et des frissons d'excitation lors de nos événements spectaculaires.",
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
                // margin: const EdgeInsets.symmetric(vertical: 5),
                child: AnimatedTextKit(
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    animatedTexts: [
                      TyperAnimatedText(
                        "Plongez dans l'adrénaline : des expériences inoubliables vous attendent !",
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
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Image.asset("assets/images/three.png"),
          ),
         const  Spacer(),
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
                        Get.off(() => const SecondPage(),
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
                        Get.off(() => const LoginPage(),
                            transition: Transition.rightToLeft);
                      },
                      child: const Text(
                        'Connexion',
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
