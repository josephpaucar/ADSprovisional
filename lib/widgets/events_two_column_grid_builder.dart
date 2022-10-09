import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

class EventsTwoColumnGridBuilder extends StatelessWidget {
  EventsTwoColumnGridBuilder({super.key});
  final List<Event> events = Event.events;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 220),
        itemCount: events.length,
        itemBuilder: ((_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(events[index].imageUrl),
                        fit: BoxFit.cover,
                      )),
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      events[index].nombre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white),
                    ))
              ],
            ),
          );
        }));
  }
}

/*
class _GridB extends StatefulWidget {
  const _GridB({super.key});

  @override
  State<_GridB> createState() => __GridBState();
}

class __GridBState extends State<_GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "First event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
    {
      "title": "Second event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
    {
      "title": "Third event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
    {
      "title": "Fourth event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
    {
      "title": "Fifth event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
    {
      "title": "Fifth event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
    {
      "title": "Fifth event of the week",
      "image": "assets/images/evento-ejemplo2.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 220),
        itemCount: gridMap.length,
        itemBuilder: ((_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image:
                            AssetImage("${gridMap.elementAt(index)['image']}"),
                        fit: BoxFit.cover,
                      )),
                  child: InkWell(
                    onTap: () {},
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black54.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "${gridMap.elementAt(index)['title']}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.white),
                    ))
              ],
            ),
          );
        }));
  }
}
*/