import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';
import 'package:orientation_app/shared/details.dart';

class EtablissmentCard extends StatefulWidget {
  final String imageLink;
  final String universityName;
  final String university;
  final String universityDetails;
  final String universityspaciality;
  final String universityStudentsNumber;
  final String universityLocation;
  final VoidCallback? onPressed;
  const EtablissmentCard({
    super.key,
    required this.imageLink,
    required this.universityName,
    required this.university,
    required this.universityDetails,
    required this.universityspaciality,
    required this.universityStudentsNumber,
    required this.universityLocation,
    required this.onPressed,
  });

  @override
  State<EtablissmentCard> createState() => _EtablissmentCardState();
}

class _EtablissmentCardState extends State<EtablissmentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Column(
        children: [
          
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                 child: FancyShimmerImage(
                    imageUrl: widget.imageLink,
                    // boxFit: BoxFit.cover,
                    width: 120,
                    height: 110,
                    errorWidget: const Icon(Icons.error),
                  ),
          
              //   child: Image.network(
              //              widget.imageLink,
              //               fit: BoxFit.cover,
              //               width: 130,
              //               // height: 240,
              //             ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25,),
                    Text(
                      widget.universityName,
                      style: const TextStyle(
                          fontSize: 16,
                          color: mainColor,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.university,
                      style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   widget.universityDetails,
                    //   style: const TextStyle(
                    //     fontSize: 13,
                    //     color: greyColor,
                    //   ),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   children: [
                    //     Details(
                    //         icons: Icons.network_cell,
                    //         description: widget.universityspaciality),
                       
                       
                    //   ],
                    // ),
                    const SizedBox(height: 5,),
                     Details(
                            icons: Icons.school,
                            description: widget.universityStudentsNumber),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Details(
                            icons: Icons.location_on,
                            description: widget.universityLocation),
                        // const Spacer(),
                        // EtablissementButton(onPressed: widget.onPressed, text: "  Voir Plus  "),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
       const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
