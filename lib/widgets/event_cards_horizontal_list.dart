import 'package:flutter/material.dart';

import '../models/app_data.dart';
import 'widgets.dart';

class EventCardsHorizontalList extends StatelessWidget {
  EventCardsHorizontalList({super.key});
  final events = Event.events;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < events.length; i++)
            EventCardStyle1(
              imageUrl: events[i].imageUrl,
              nombre: events[i].nombre,
            ),
        ],
      ),
    );
  }
}
