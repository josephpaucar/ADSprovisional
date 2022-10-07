import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

class PostCommentsPage extends StatelessWidget {
  const PostCommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final post = Post.posts[0];
    final comments = Comment.comments; // Pregintar a GianCarlo
    List<Comment> postComments = [];

/*    for (int i = 0; i < comments.length; i++) {
      if (comments[i].postId == postId) {
        postComments.add(comments[i]);
      }
    }*/

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          post.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              for (int i = 0; i < postComments.length; i++)
                _CommentSingle(
                  user: postComments[i].user.name,
                  initials: postComments[i].user.userInitials,
                  commentContent: postComments[i].commentContent,
                  createdTime: postComments[i].createdTime,
                ),
            ],
          )),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5))))),
                onPressed: () {},
                child: const Text(
                  'Añadir comentario',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.w300),
                ),
              ))
        ],
      ),
    );
  }
}

class _CommentSingle extends StatelessWidget {
  final String user;
  final String initials;
  final String commentContent;
  final String createdTime;

  const _CommentSingle({
    Key? key,
    required this.user,
    required this.initials,
    required this.commentContent,
    required this.createdTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 2),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF396A1E),
                foregroundColor: Colors.white,
                child: Text(initials),
              ),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    user,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    commentContent,
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  ),
                  Text(
                    createdTime,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black87),
                  )
                ]))
          ]),
    );
  }
}
