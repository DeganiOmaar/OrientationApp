import 'package:flutter/material.dart';

class SkeletonCardEtab extends StatefulWidget {
  const SkeletonCardEtab({super.key});

  @override
  State<SkeletonCardEtab> createState() => _SkeletonCardEtabState();
}

class _SkeletonCardEtabState extends State<SkeletonCardEtab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        const Skelton(
          width: 130,
          height: 190,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const SizedBox(
              height: 5,
            ),
            const Skelton(
              height: 20,
            ),
            const SizedBox(
              height: 5,
            ),
            const  Skelton(
              width: 80,
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Skelton(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 30,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Skelton(
                  width: 10,
                  height: 10,
                ),
                const SizedBox(
                  width: 5,
                ),
                Skelton(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Skelton(
                  width: 15,
                  height: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Skelton(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                Skelton(
                  width: 15,
                  height: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Skelton(
                  width: 65,
                  height: 15,
                ),
                Spacer(),
                Skelton(
                  width: 100,
                  height: 35,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        )
      ]),
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
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
