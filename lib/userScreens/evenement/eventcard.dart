import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/colors.dart';

class EventCard extends StatelessWidget {
  final String imgLink;
  final String eventday;
  final String title;
  final String eventtime;
  final String location;
  final String description;
  const EventCard(
      {super.key,
      required this.imgLink,
      required this.eventday,
      required this.title,
      required this.eventtime,
      required this.location, required this.description
      
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(imgLink, scale: 1.0),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    eventday,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 226, 206, 22)),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            color: mainColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            eventtime,
                            style: const TextStyle(fontSize: 14, color: greyColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationDot,
                            color: mainColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            location,
                            style: const TextStyle(fontSize: 14, color: greyColor),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    // textAlign: TextAlign.justify,
                    maxLines: 3,
                    // overflow: TextOverflow.fade,
                  ),
                ],
              ),
            )
          ],
        ),
      const SizedBox(height: 20,)
      ],
    );
  }
}
