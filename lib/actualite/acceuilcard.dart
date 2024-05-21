import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class AcceuilCard extends StatelessWidget {
  final String firstImageLink;
  final String firstTitle;
  const AcceuilCard(
      {super.key,
      required this.firstImageLink,
      required this.firstTitle,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      ClipRRect(
                borderRadius: const BorderRadius.all(
                   Radius.circular(15),
               
                ),

               child: FancyShimmerImage(
              imageUrl: firstImageLink,
              boxFit: BoxFit.cover,
            //  width: MediaQuery.of(context).size.width * 0.30,
              height: 120,
              errorWidget: const Icon(Icons.error),
            ),

            //     child: Image.network(
            //    firstImageLink,
            //       fit: BoxFit.cover,
            //       // width: MediaQuery.of(context).size.width * 0.4,
            //       height: 120,
            // )
                ),
        const Gap(10),
        Text(
          firstTitle,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
              // textAlign: TextAlign.justify,
               maxLines: 3
        )
      ],
    );
  }
}
