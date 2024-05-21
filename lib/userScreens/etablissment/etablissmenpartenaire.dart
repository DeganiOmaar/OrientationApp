import 'package:flutter/material.dart';

class PartenaireEtablissment extends StatelessWidget {
  final String link;
  const PartenaireEtablissment({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return   CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage(link),
            );
  }
}