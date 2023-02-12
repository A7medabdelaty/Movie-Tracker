import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/models/movie_model.dart';

class DataBaseUtils {
  static CollectionReference<Results> getWatchListCollection() {
    return FirebaseFirestore.instance.collection('WatchList').withConverter(
          fromFirestore: (snapshot, options) =>
              Results.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addMovieToFireStore(Results movie) {
    return getWatchListCollection().doc('${movie.id}').set(movie);
  }

  static Future<void> removeMovieFromFireStore(Results movie) {
    return getWatchListCollection().doc('${movie.id}').delete();
  }

  static Future<QuerySnapshot<Results>> getWatchList() {
    return getWatchListCollection().get();
  }
}
