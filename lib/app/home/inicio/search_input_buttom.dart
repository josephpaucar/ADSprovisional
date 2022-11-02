import 'package:aves_de_san_martin/app/home/birds/bird_catalog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../birds/bird_info_page.dart';

class SearchInputButton extends StatelessWidget {
  const SearchInputButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ButtonStyle(
              alignment: Alignment.center,
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))))),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BirdCatalog()),
            );
            /*showSearch(
              context: context,
              delegate: MySearchDelegate(),
            );*/
          },
          child: const Text(
            'Catálogo de aves',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
        ));
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar por nombre científico';

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('aves')
            .where('nombreCientifico', isGreaterThanOrEqualTo: query)
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
              title:
                  Text(snapshot.data!.docs[index].data()['nombreCientifico']),
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
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('aves').get(),
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
              title:
                  Text(snapshot.data!.docs[index].data()['nombreCientifico']),
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
        });
  }
}
