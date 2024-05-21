import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orientation_app/shared/colors.dart';

class AllAvis extends StatefulWidget {
  final String faculteid;
  const AllAvis({super.key, required this.faculteid});

  @override
  State<AllAvis> createState() => _AllAvisState();
}

class _AllAvisState extends State<AllAvis> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController avisController = TextEditingController();
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Tous les Avis",
            style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('etablissment')
                  .doc(widget.faculteid)
                  .collection("AvisEtudiants")
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                            ),
                            const Gap(10),
                            Column(
                              children: [
                                Text(
                                  data['nom'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
                                ),
                                const Gap(15)
                              ],
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data['avis'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: greyColor,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            const Gap(5),
                            Column(
                              children: [
                                data['userid'] == userData['uid']
                                    ? IconButton(
                                        onPressed: () {
                                          avisController.text = data['avis'];// Pre-fill the TextField with existing avis
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                const Text(
                                                              "Retour",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )),
                                                        TextButton(
                                                            onPressed:
                                                                () async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'etablissment')
                                                                  .doc(widget
                                                                      .faculteid)
                                                                  .collection(
                                                                      'AvisEtudiants')
                                                                  .doc(data[
                                                                      'avisid'])
                                                                  .update({
                                                                'avis': avisController.text ==
                                                                        ""
                                                                    ? data[
                                                                        'avis']
                                                                    : avisController
                                                                        .text
                                                              });
                                                              avisController.clear();
                                                              if (!mounted)return;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
        
                                                              setState(
                                                                  () {});
                                                            },
                                                            child:
                                                                const Text(
                                                              "Modifier",
                                                              style: TextStyle(
                                                                  color:
                                                                      mainColor),
                                                            ))
                                                      ],
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .all(20),
                                                      content: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9, // <-- TextField width
                                                        height:
                                                            180, // <-- TextField height
                                                        child: TextField(
                                                          controller: avisController,
                                                          maxLines: null,
                                                          expands: true,
                                                          
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            // filled: true,
                                                            fillColor: Colors
                                                                .black38,
                                                            hintText: data[
                                                                'avis'],
                                                            hintStyle: const TextStyle(
                                                                color: Colors
                                                                    .black87),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        220,
                                                                        220,
                                                                        220),
                                                              ),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        220,
                                                                        220,
                                                                        220),
                                                              ),
                                                            ),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        15),
                                                          ),
                                                        ),
                                                      )));
                                        },
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          color: Colors.green,
                                        ))
                                    : Container(),
                                data['userid'] == userData['uid']
                                    ? IconButton(
                                        onPressed: () async{
                                          
                                              await FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                      "etablissment")
                                                  .doc(widget.faculteid)
                                                  .collection(
                                                      'AvisEtudiants')
                                                  .doc(data['avisid'])
                                                  .delete();
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ))
                                    : userData['role'] == 'admin'
                                        ? IconButton(
                                            onPressed: () async {
                                              await FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                      "etablissment")
                                                  .doc(widget.faculteid)
                                                  .collection(
                                                      'AvisEtudiants')
                                                  .doc(data['avisid'])
                                                  .delete();
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ))
                                        : Container(),
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  }).toList(),
                );
              },
            )),
                  );
  }
}
