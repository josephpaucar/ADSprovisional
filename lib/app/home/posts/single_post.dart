import 'package:aves_de_san_martin/app/home/posts/post_comments_page.dart';
import 'package:aves_de_san_martin/common_widgets/like_animation.dart';
import 'package:aves_de_san_martin/services/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SinglePost extends StatefulWidget {
  final Map<String, dynamic> snapshot;

  const SinglePost({super.key, required this.snapshot});

  @override
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(children: [
        Container(
            width: double.infinity,
            height: 550,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.snapshot['photoUrl'])),
            )),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: LikeAnimation(
                    isAnimating: widget.snapshot['likes'].contains(uid),
                    smallLike: true,
                    child: GestureDetector(
                      child: widget.snapshot['likes'].contains(uid)
                          ? const Icon(Icons.favorite, color: Color(0xFF9B442B))
                          : const Icon(Icons.favorite_border,
                              color: Color(0xFF9B442B)),
                      onTap: () async {
                        await FirestoreMethods().likePost(
                            widget.snapshot['postId'],
                            uid,
                            widget.snapshot['likes']);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: GestureDetector(
                    child: const Icon(Icons.forum, color: Color(0xFF9B442B)),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PostCommentsPage(
                                snap: widget.snapshot,
                              )));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    '${widget.snapshot['likes'].length} likes',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          width: double.infinity,
          child: Row(children: [
            Text(widget.snapshot['username'],
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            Text(
              widget.snapshot['title'],
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
          ]),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.snapshot['postId'])
                  .collection('comments')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final commentsLen = snap.data!.docs.length;
                return Text('$commentsLen comentarios');
              },
            )),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostCommentsPage(
                            snap: widget.snapshot,
                          )),
                );
              },
              child: const Text(
                'Añadir comentario',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w300),
              ),
            ))
      ]),
    );
  }
}
