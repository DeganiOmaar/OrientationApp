import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final String title;
  final String text;
  const ProfileCard({super.key, required this.title, required this.text});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 10),
      child: Row(
        children: [
          Text(
           widget.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
          widget.text,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          )
        ],
      ),
    );
  }
}