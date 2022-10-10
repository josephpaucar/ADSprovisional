import 'package:cloud_firestore/cloud_firestore.dart';
import 'api_path.dart';
import '../app/home/models/recomendation.dart';

abstract class Database {
  // Stream<Iterable<Attraction>> attractionsStream();
  Stream<Iterable<Recomendation>> recomendationStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  @override
  Stream<Iterable<Recomendation>> recomendationStream() {
    final path = APIPath.recomendation();
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((element) {
          final data = element.data();
          return Recomendation(
            id: data['id'],
            description: data['description'],
            category: data['category'],
          );
        }).toList());
  }

/*

  @override
  Stream<Iterable<Attraction>> attractionsStream() {
    final path = APIPath.attractions();
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((element) {
          final data = element.data();
          return Attraction(
            id: id,
            name: data['name'],
          );
        }));
  }
  */
}
