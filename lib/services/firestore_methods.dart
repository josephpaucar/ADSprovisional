import 'package:aves_de_san_martin/app/home/models/post.dart';
import 'package:aves_de_san_martin/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String title,
    String description,
    String attractionId,
    Uint8List file,
    String uid,
    String username,
  ) async {
    String res = "Some error ocurred";

    try {
      String photoUrl =
          await Storage().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      String _attractionId = attractionId.toLowerCase().replaceAll(' ', '');
      Post post = Post(
        description: description,
        title: title,
        username: username,
        uid: uid,
        postId: postId,
        datePublished: DateTime.now(),
        photoUrl: photoUrl,
        likes: [],
        attractionId: _attractionId,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(
      String postId, String text, String uid, String name) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'username': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
