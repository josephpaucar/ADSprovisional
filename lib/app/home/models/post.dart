import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String title;
  final String username;
  final String uid;
  final String postId;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;
  final String photoUrl;
  final String attractionId;
  // ignore: prefer_typing_uninitialized_variables
  final likes;

  const Post({
    required this.description,
    required this.title,
    required this.username,
    required this.uid,
    required this.postId,
    required this.datePublished,
    required this.photoUrl,
    required this.attractionId,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'description': description,
        'title': title,
        'username': username,
        'uid': uid,
        'postId': postId,
        'datePublished': datePublished,
        'photoUrl': photoUrl,
        'attractionId': attractionId,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot['description'],
      title: snapshot['title'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      photoUrl: snapshot['photoUrl'],
      likes: snapshot['likes'],
      attractionId: snapshot['attractionId'],
    );
  }
}
