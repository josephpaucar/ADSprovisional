import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../posts/single_post.dart';

class AllPostsInAttractionPage extends StatelessWidget {
  const AllPostsInAttractionPage(
      {super.key, required this.attractionId, required this.attractionName});
  final String attractionId;
  final String attractionName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Fotos en $attractionName',
            style: const TextStyle(fontFamily: 'BreePeru'),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('attractionId', isEqualTo: attractionId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('An error ocurred.'));
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                'No posts in this Attraction',
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 20, color: Colors.black54),
              ));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return SinglePost(snapshot: snapshot.data!.docs[index].data());
              },
            );
          },
        ));
  }
}

/* snapshot.data!.docs.map((document) {
              return SinglePost(snapshot: document.data());
            }).toList() */
