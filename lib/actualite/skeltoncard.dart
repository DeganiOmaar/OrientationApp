import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SkeltonCard extends StatelessWidget {
  const SkeltonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skelton(

          width: MediaQuery.of(context).size.width * 0.45,
          height: 120,
        ),

        // Container(
        //   // width: MediaQuery.of(context).size.width * 0.4,
        //   height: 120,
        // ),
        const Gap(20),

        Skelton(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 25,
        ),
         const Gap(20),

        Skelton(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 25,
        ),
      ],
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({
    this.height,
    this.width,
    super.key,
  });
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
        padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
      color: Colors.grey[200], 
      borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
    );
  }
}
