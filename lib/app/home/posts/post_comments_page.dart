import 'package:aves_de_san_martin/app/home/posts/input_decoration.dart';
import 'package:aves_de_san_martin/services/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCommentsPage extends StatefulWidget {
  const PostCommentsPage({super.key, required this.snap});
  final snap;

  @override
  State<PostCommentsPage> createState() => _PostCommentsPageState();
}

class _PostCommentsPageState extends State<PostCommentsPage> {
  final username = FirebaseAuth.instance.currentUser!.displayName;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Comentarios',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.snap['postId'])
                  .collection('comments')
                  .orderBy('datePublished', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) => _CommentSingle(
                      snapshot: (snapshot.data! as dynamic).docs[index].data()),
                );
              },
            )),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecorations.authInputDecoration(
                            hintText: 'Comment as $username',
                            labelText: 'Comentario'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 20),
                      child: GestureDetector(
                          onTap: () async {
                            FirestoreMethods().postComment(
                                widget.snap['postId'],
                                commentController.text,
                                uid,
                                username!);
                            setState(() {
                              commentController.text = "";
                            });
                          },
                          child: const Icon(
                            Icons.send,
                            color: Color(0xFF396A1E),
                          )),
                    )
                  ],
                )),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}

class _CommentSingle extends StatelessWidget {
  final snapshot;

  const _CommentSingle({
    Key? key,
    required this.snapshot,
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
            const Padding(
              padding: EdgeInsets.only(right: 8, top: 2),
              child: CircleAvatar(
                backgroundColor: Color(0xFF396A1E),
                foregroundColor: Colors.white,
                child: Text('JP'),
              ),
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    snapshot['username'],
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    snapshot['text'],
                    style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
                  ),
                  Text(
                    DateFormat.yMMMd()
                        .format(snapshot['datePublished'].toDate()),
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
