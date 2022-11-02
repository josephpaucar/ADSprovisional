import 'package:aves_de_san_martin/app/home/birds/bird_info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'rutas_bird_card.dart';

class AllBirdsInAttractionPage extends StatelessWidget {
  const AllBirdsInAttractionPage(
      {super.key, required this.attractionId, required this.attractionName});
  final String attractionId;
  final String attractionName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Aves en $attractionName',
          style: const TextStyle(fontFamily: 'BreePeru'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("aves")
              .where("avistadoEn", arrayContains: attractionId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 220,
              ),
              children: snapshot.data!.docs.map((document) {
                return RutasBirdCard(
                  id: document['id'],
                  imageUrl: document['imageUrl'][0],
                  nombreCientifico: document['nombreCientifico'],
                  nombreComun: document['nombreComun'],
                  birdInfo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BirdInfoPage(
                                birdId: document['id'],
                              )),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
