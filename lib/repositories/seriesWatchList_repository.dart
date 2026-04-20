import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grey_matter/model/movie/movie_model.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';

class WatchlistRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  WatchlistRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addToWatchListSeries(AiringTodayResults series) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception('User not found');
    }

    await _firestore
        .collection('WatchList')
        .doc(userId)
        .collection('Series')
        .doc('${series.id}')
        .set({
          'id': series.id,
          'episodeId': series.episodeId,
          'title': series.name,
          'episodeName': series.episodeName,
          'seasonNumber': series.seasonNumber,
          'episodeNumber': series.episodeNumber,
          'overview': series.overview,
          'poster_path': series.posterPath,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  Future<void> removeFromWatchListSeries(int seriesId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User Not Found');
    }

    await _firestore
        .collection('WatchList')
        .doc(userId)
        .collection('Series')
        .doc('${seriesId}')
        .delete();
  }

  Future<void> addToWatchListMovie(Result movie) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception('User Not Found');
    }

    await _firestore
        .collection('WatchList')
        .doc(userId)
        .collection('Movie')
        .doc('${movie.id}')
        .set({
          'id': movie.id,
          'title': movie.title,
          'genreName': movie.genreName,
          'overview': movie.overview,
          'poster_path': movie.posterPath,
          'releaseYear': movie.releaseYear,
          'voteAverage': movie.voteAverage,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  Future<void> removeFromWatchListMovie(int movieId) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User Not Found');
    }

    await _firestore
        .collection('WatchList')
        .doc(userId)
        .collection('Movie')
        .doc('${movieId}')
        .delete();
  }

  Future<List<AiringTodayResults>> fetchWatchListSeries() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      throw Exception('User Not Found');
    }
    final snapshots = await _firestore
        .collection('WatchList')
        .doc(userId)
        .collection('Series')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshots.docs.map((doc) {
      final data = doc.data();

      return AiringTodayResults(
        id: data['id'],
        episodeName: data['episodeName'],
        episodeId: data['episodeId'],
        seasonNumber: data['seasonNumber'],
        episodeNumber: data['episodeNumber'],
        name: data['title'],
        overview: data['overview'],
        posterPath: data['poster_path'],
      );
    }).toList();
  }

  Future<List<Result>> fetchWatchListMovies() async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception('User Not Found');
    }

    final snapshots = await _firestore
        .collection('WatchList')
        .doc(userId)
        .collection('Movie')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshots.docs.map((doc) {
      final data = doc.data();
      return Result(
        id: data['id'],
        releaseYear: data['releaseYear'],
        genreName: data['genreName'],
        voteAverage: data['voteAverage'],
        title: data['title'],
        overview: data['overview'],
        posterPath: data['poster_path'],
      );
    }).toList();
  }
}
