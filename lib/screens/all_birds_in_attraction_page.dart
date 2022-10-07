import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

import '../widgets/widgets.dart';

class AllBirdsInAttractionPage extends StatelessWidget {
  AllBirdsInAttractionPage({super.key});
  final List<Bird> birds = Bird.birds;

  @override
  Widget build(BuildContext context) {
    List<Bird> birdsInAttraction = [];

    /*for (int i = 0; i < birds.length; i++) {
      for (int j = 0; j < birds[i].avistadoEn.length; j++) {
        if (attractionId == birds[i].avistadoEn[j]) {
          birdsInAttraction.add(birds[i]);
        }
      }
    }*/

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aves de San Martin',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: birdsInAttraction.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 180),
            itemBuilder: (_, index) {
              return BirdCardStyle3(
                id: birdsInAttraction[index].id,
                imageUrl: birdsInAttraction[index].imageUrl,
                nombreCientifico: birdsInAttraction[index].nombreCientifico,
                nombreComun: birdsInAttraction[index].nombreComun,
              );
            }),
      ),
    );
  }
}
