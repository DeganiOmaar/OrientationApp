import 'package:flutter/material.dart';
import 'package:orientation_app/shared/colors.dart';

class AvisEtablissement extends StatelessWidget {
  final String name;
  final String description;
  // final VoidCallback? onPressed;
  const AvisEtablissement(
      {super.key,
      required this.name,
      required this.description,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.28,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: secondaryColor,
                overflow: TextOverflow.fade),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 12),
            // textAlign: TextAlign.justify,
            maxLines: 4,
          )
        ],
      ),
    );
  }
}
