import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/lyceeScreens/questionScreens/reponse.dart';
import 'package:orientation_app/shared/colors.dart';

class Avis extends StatefulWidget {
  const Avis({super.key});

  @override
  State<Avis> createState() => _AvisState();
}

class _AvisState extends State<Avis> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            // backgroundColor: Colors.white,
            // ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(children: [
               const  Text("Vous pouvez poser vos questions ici afin d'obtenir plus de détails et des réponses pour vous aider dans vos études.", 
                style: TextStyle(fontSize: 16, color: blackColor, fontWeight: FontWeight.w600), textAlign: TextAlign.justify,),
                const Gap(10),
                Expanded(
                  // height: 200,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        // .orderBy('paidDate', descending: true)
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

                      return SingleChildScrollView(
                        // scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Reponse(
                                              nom: data['nom'],
                                              niveau: data['niveau'],
                                              etablissement:
                                                  data['etablissment'],
                                              question: data['question'],
                                              postId: data['post_id'],
                                              userPublishedId: data['uid'],
                                              myToken: data['token'],
                                            )));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(25),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                                      ),
                                      const Gap(10),
                                      Column(children: [
                                        Text(
                                          data['nom'],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: mainColor),
                                        ),
                                        Text(
                                          data['niveau'],
                                          style: const TextStyle(
                                              fontSize: 14, color: greyColor),
                                        ),
                                      ])
                                    ],
                                  ),
                                  const Gap(15),
                                  Text(data['etablissment'],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  const Gap(10),
                                  Text(
                                    data['question'],
                                    style: const TextStyle(color: greyColor),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            )));
  }
}
