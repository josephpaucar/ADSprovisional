import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';
import '../widgets/widgets.dart';

class PostsPage extends StatelessWidget {
  PostsPage({super.key});
  final posts = Post.posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aves de San Martin',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.add_a_photo,
                  size: 24.0,
                ),
              )),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, i) {
          return SinglePost(
            postId: posts[i].id,
            imageUrl: posts[i].imageUrl,
            title: posts[i].title,
            description: posts[i].description,
            totalComments: posts[i].totalComments,
            user: posts[i].user,
            totalLikes: posts[i].totalLikes,
          );
        },
      ),
    );
  }
}
