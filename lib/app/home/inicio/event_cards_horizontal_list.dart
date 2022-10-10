import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_event_card.dart';

class EventCardsHorizontalList extends StatelessWidget {
  const EventCardsHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("eventos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: const EdgeInsets.only(left: 16),
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return HomeEventCard(
                    imageUrl: document['imageUrl'],
                    nombre: document['nombre'],
                    siteUrl: document['webUrl']);
              }).toList(),
            ),
          );
        });
  }
}
