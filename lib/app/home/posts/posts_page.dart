import 'package:aves_de_san_martin/app/home/posts/create_post_page.dart';
import 'package:aves_de_san_martin/app/home/posts/single_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Aves Nor Amazónicas Perú',
            style: TextStyle(fontFamily: 'BreePeru'),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePostPage()),
                    );
                  },
                  icon: const Icon(
                    Icons.add_a_photo,
                    size: 24.0,
                  ),
                )),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('datePublished', descending: true)
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
