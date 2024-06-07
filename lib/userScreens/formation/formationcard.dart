import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orientation_app/userScreens/formation/details.dart';

import '../../shared/colors.dart';

class FormationCard extends StatefulWidget {
  final String imageLink;
  final String formationType;
  final String comapgnyName;
  final String formationName;
  final String formationDuration;
  final String formationCertified;
  final String formationPlace;
  final String formationPrice;
  final VoidCallback? onPressed;

  const FormationCard(
      {super.key,
      required this.imageLink,
      required this.formationType,
      required this.comapgnyName,
      required this.formationName,
      required this.formationDuration,
      required this.formationCertified,
      required this.formationPlace, 
      required this.formationPrice,
      required this.onPressed});

  @override
  State<FormationCard> createState() => _FormationCardState();
}

class _FormationCardState extends State<FormationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                      child: FancyShimmerImage(
                imageUrl:widget.imageLink,
                // boxFit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.4,
                 height: 125,
                errorWidget: const Icon(Icons.error),
              ),
                    ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      widget.formationType,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: blackColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.comapgnyName,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.formationName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: blackColor),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailsFormation(
                    text: widget.formationDuration, icon: FontAwesomeIcons.clock),
                DetailsFormation(
                    text: widget.formationCertified, icon: Icons.network_cell),
                DetailsFormation(
                    text: widget.formationPlace, icon: FontAwesomeIcons.clock),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
               padding: const EdgeInsets.only(left: 20.0),
               child: Text(
                widget.formationPrice,
                 style: const TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: blackColor),
               ),
                                ),
            )
          ],
        ),
      ),
    );
  }
}
