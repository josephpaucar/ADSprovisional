import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'services_card.dart';

class ServicesTwoColumnGridBuilder extends StatelessWidget {
  const ServicesTwoColumnGridBuilder(
      {super.key, required this.serviceCategory});
  final String serviceCategory;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("servicios")
          .where("categoria", isEqualTo: serviceCategory)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return ServicesCard(
              destino: document['destino'],
              nombre: document['nombre'],
            );
          }).toList(),
        );
      },
    );
  }
}
