import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'inforbourses.dart';

class BouseCard extends StatelessWidget {
  final String imgLink;
  final String bourseName;
  final String location;
  final String diplomeName;
  final String time;
  final String tempsPartiel;
  final String description;
  final VoidCallback? onPressed;

  const BouseCard(
      {super.key,
      required this.imgLink,
      required this.bourseName,
      required this.location,
      required this.diplomeName,
      required this.time,
      required this.tempsPartiel,
      required this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            // height: 205,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Row(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                       child: FancyShimmerImage(
                    imageUrl: imgLink,
                    // boxFit: BoxFit.cover,
                   width: MediaQuery.of(context).size.width * 0.30,
                    height: 110,
                    errorWidget: const Icon(Icons.error),
                  ),
          
                // child: 
                // Image.network(
                //        imgLink,
                //           // fit: BoxFit.cover,
                //           width: MediaQuery.of(context).size.width * 0.30,
                //           // height: 230,
                //     )
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bourseName,
                        style:
                            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InfoBourses(
                                text: location, icon: FontAwesomeIcons.locationDot),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Expanded(child: InfoBourses(text: diplomeName, icon: Icons.network_cell)),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(child: InfoBourses(text: time, icon: FontAwesomeIcons.clock)),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Expanded(
                            child: InfoBourses(
                                text: tempsPartiel, icon: FontAwesomeIcons.graduationCap),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // Text(
                      //   description,
                      //   style: const TextStyle(
                      //     fontSize: 13,
                      //     color: greyColor,
                      //   ),
                      //   textAlign: TextAlign.justify,
                      //   maxLines: 3,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      // BourseButton(onPressed: onPressed, textButton: " Voir Plus "), 
                  
                      //   ],
                      // ),
                      
                    ],
                  ),
                ),
              )
            ]),
          ),
          const SizedBox(height: 20,),       
        ],
      ),
    );
  }
}
