import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../shared/colors.dart';

class Technique extends StatefulWidget {
  const Technique({super.key});

  @override
  State<Technique> createState() => _TechniqueState();
}

class _TechniqueState extends State<Technique> {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(child: Scaffold(
      body: Padding(
        padding:  const EdgeInsets.symmetric(horizontal:20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15,),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: const Icon(FontAwesomeIcons.arrowLeft)),
                  const Gap(60)
,                  const Text("Pour le 2éme Sciences", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ],
              ),
              const SizedBox(height: 15,),
              const Divider(), 
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Matiére", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("Mathématiques", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Physique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Sciences", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Technique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Arabe", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Français", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Anglais", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Informatque", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Histoire", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Geographie", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Islamique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Civique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Sport", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Temps", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3.5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1.5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1.5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Coéfficient", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("4", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1.5", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 
                ],
              ), 
              const SizedBox(height: 10,),
              const Divider(), 
               const SizedBox(height: 15,),
              const Text("Pour le 3éme Technique", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              const SizedBox(height: 15,),
              const Divider(), 
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Matiére", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("Arabe", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Français", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Anglais", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Histoire", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Geographie", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("phylosophie", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Technique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Mathématiques", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Physique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Informatique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Sport", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Sujet optionnel", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Temps", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("3h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("8h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1.5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Coéfficient", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 
                ],
              ), 
              const SizedBox(height: 10,),
              const Divider(), 
                  const SizedBox(height: 10,),
              const Text("Pour le Bac Technique", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              const SizedBox(height: 15,),
              const Divider(), 
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Matiére", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("Arabe", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Français", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Anglais", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("phylosophie", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Mathématiques", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Physique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Technique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Informatique", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Sport", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("Sujet optionnel", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Temps", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("8h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1.5h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("2h/Semaine", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Coéfficient", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("3", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("4", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                      Gap(30),
                      Text("1", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, ),),
                    ],
                  ), 
                 
                ],
              ), 
              const SizedBox(height: 10,),
              const Divider()
            ],
          ),
        ),
      ),
    ));
 
  }
}