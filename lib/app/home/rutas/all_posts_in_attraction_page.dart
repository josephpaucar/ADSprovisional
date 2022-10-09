import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';
import '../../../widgets/widgets.dart';

class AllPostsInAttractionPage extends StatelessWidget {
  AllPostsInAttractionPage({super.key, required this.attractionId});
  final String attractionId;

  final List<Post> posts = Post.posts;

  @override
  Widget build(BuildContext context) {
    List<Post> postsInAttraction = [];

    for (int i = 0; i < posts.length; i++) {
      if (attractionId == posts[i].tomadoEn) {
        postsInAttraction.add(posts[i]);
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Aves de San Martin',
            style: TextStyle(fontFamily: 'BreePeru'),
          ),
        ),
        body: ListView.builder(
            itemCount: postsInAttraction.length,
            itemBuilder: (context, index) {
              return SinglePost(
                postId: postsInAttraction[index].id,
                imageUrl: postsInAttraction[index].imageUrl,
                title: postsInAttraction[index].title,
                description: postsInAttraction[index].description,
                totalComments: postsInAttraction[index].totalComments,
                user: postsInAttraction[index].user,
                totalLikes: postsInAttraction[index].totalLikes,
              );
            }));
  }
}
