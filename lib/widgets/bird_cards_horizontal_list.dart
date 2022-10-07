import 'package:flutter/material.dart';
import '../models/app_data.dart';
import 'widgets.dart';

class BirdCardsHorizontalList extends StatelessWidget {
  BirdCardsHorizontalList({super.key});
  final birds = Bird.birds;

  @override
  Widget build(BuildContext context) {
    final List<Bird> representativeBirds = [];

    for (int i = 0; i < birds.length; i++) {
      if (birds[i].isRepresentative) {
        representativeBirds.add(birds[i]);
      }
    }

    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < representativeBirds.length; i++)
            BirdCardStyle1(
              description: representativeBirds[i].habitat,
              imageUrl: representativeBirds[i].imageUrl,
              nombreCientifico: representativeBirds[i].nombreCientifico,
              nombreComun: representativeBirds[i].nombreComun,
              id: representativeBirds[i].id,
            ),
        ],
      ),
    );
  }
}
