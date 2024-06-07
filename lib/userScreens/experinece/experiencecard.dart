import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/userScreens/bourses/inforbourses.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class ExperienceCard extends StatelessWidget {
  final String imgLink;
  final String category;
  final String branche;
  final String name;
  final String location;
  final String niveaudetude;
  final String duree;
  final String facultename;
  final VoidCallback? onPressed;
  const ExperienceCard(
      {super.key,
      required this.imgLink,
      required this.category,
      required this.branche,
      required this.name,
      required this.location,
      required this.niveaudetude,
      required this.duree,
      required this.facultename,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 170,
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
          
                  child: FancyShimmerImage(
                    imageUrl: imgLink,
                    boxFit: BoxFit.cover,
                    width: 130,
                    height: 200,
                    errorWidget: const Icon(Icons.error),
                  ),
                  // child: Image.network(
                  //          imgLink,
                  //           fit: BoxFit.cover,
                  //           width: 130,
                  //           // height: 240,
                  //         )
                ),
                const SizedBox(
                  width: 25,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                                fontSize: 14,
                                color: blackColor,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            branche,
                            style: const TextStyle(color: mainColor, fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InfoBourses(
                              text: location, icon: FontAwesomeIcons.locationDot),
                          const SizedBox(
                            width: 40,
                          ),
                          InfoBourses(text: niveaudetude, icon: Icons.network_cell),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          InfoBourses(text: duree, icon: FontAwesomeIcons.clock),
                          const SizedBox(
                            width: 40,
                          ),
                          InfoBourses(
                              text: facultename, icon: FontAwesomeIcons.university),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     BourseButton(
                      //         onPressed: onPressed, textButton: " Voir Plus "),
                      //     const SizedBox(
                      //       width: 10,
                      //     )
                      //   ],
                      // ), 
                 
                    ],
                  ),
                )
              ],
            ),
          ),
        const SizedBox(height:15),
        ],
      ),
    );
  }
}
