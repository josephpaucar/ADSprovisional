import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';

class SinglePost extends StatelessWidget {
  final int postId;
  final String imageUrl;
  final String title;
  final String description;
  final int totalComments;
  final User user;
  final int totalLikes;

  const SinglePost(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.totalComments,
      required this.user,
      required this.totalLikes,
      required this.postId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(children: [
        Stack(children: [
          Container(
              width: double.infinity,
              height: 550,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imageUrl)),
              )),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.bookmark_add),
              color: Colors.white,
              onPressed: () {},
            ),
          )
        ]),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: GestureDetector(
                    child: const Icon(Icons.favorite_border,
                        color: Color(0xFF9B442B)),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: GestureDetector(
                    child: const Icon(Icons.forum, color: Color(0xFF9B442B)),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    '$totalLikes likes',
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
            Text(user.name,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            Text(
              title,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Text('$totalComments comentarios',
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12)),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))))),
              onPressed: () {},
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
