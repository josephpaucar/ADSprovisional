import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'bird_info_page.dart';

class BirdCatalog extends StatelessWidget {
  const BirdCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aves Nor Amazónicas Perú',
          style: TextStyle(fontFamily: 'BreePeru'),
        ),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('aves')
              .orderBy('nombreCientifico', descending: false)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Text('An error ocurred.');
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(snapshot.data!.docs[index].data()['icon']),
                ),
                title: Text(
                    snapshot.data!.docs[index].data()['nombreCientifico'],
                    style: const TextStyle(fontFamily: 'Poppins')),
                subtitle: Text(
                    snapshot.data!.docs[index].data()['nombreIngles'],
                    style: const TextStyle(fontFamily: 'Poppins')),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BirdInfoPage(
                            birdId: snapshot.data!.docs[index].data()['id'])),
                  );
                },
              ),
            );
          }),
    );
  }
}
