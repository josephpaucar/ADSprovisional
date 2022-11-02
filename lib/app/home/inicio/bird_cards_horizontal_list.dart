import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_bird_card.dart';

class BirdCardsHorizontalList extends StatelessWidget {
  const BirdCardsHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("aves")
            .where("esRepresentativa", isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((document) {
                return HomeBirdCard(
                  id: document['id'],
                  imageUrl: document['imageUrl'][0],
                  nombreComun: document['nombreComun'],
                  nombreCientifico: document['nombreCientifico'],
                  habitat: document['habitat'],
                );
              }).toList(),
            ),
          );
        });
  }
}
