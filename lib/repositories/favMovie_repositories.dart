import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/movie/movie_model.dart';

class FavMovieRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FavMovieRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addToFavMovie(Result movie) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    await _firestore
        .collection('favourite_movies')
        .doc(userId)
        .collection('movies')
        .doc('${movie.id}')
        .set({
      'id':movie.id,
      'title': movie.title,
      'genreName':movie.genreName,
      'overview': movie.overview,
      'poster_path': movie.posterPath,
      'releaseYear':movie.releaseYear,
      'voteAverage':movie.voteAverage,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFavourite(int movieId) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    await _firestore
        .collection('favourite_movies')
        .doc(userId)
        .collection('movies')
        .doc('${movieId}')
        .delete();
  }

  Stream<List<Result>> fetchFavMovies() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception("User not logged in");

    return _firestore
        .collection('favourite_movies')
        .doc(userId)
        .collection('movies')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return Result(
          id: data['id'],
          title: data['title'],
          overview: data['overview'],
          posterPath: data['poster_path'],
          voteAverage: data['voteAverage'],
          genreName: data['genreName'],
          releaseYear: data['releaseYear'],
        );
      }).toList();
    });
  }
}