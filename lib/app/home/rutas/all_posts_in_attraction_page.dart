import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

import '../posts/single_post.dart';

class AllPostsInAttractionPage extends StatelessWidget {
  AllPostsInAttractionPage({super.key, required this.attractionId});
  final String attractionId;

  final List<Post> posts = Post.posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Aves de San Martin',
            style: TextStyle(fontFamily: 'BreePeru'),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('attractionId', isEqualTo: attractionId)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  SinglePost(snapshot: snapshot.data!.docs[index].data()),
            );
          },
        ));
  }
}
