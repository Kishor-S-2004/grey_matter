import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grey_matter/model/movie/movie_review.dart';

class MovieReviewRepo {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  MovieReviewRepo({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addReviews(MovieReviewResults results) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User Does not Exist');
    }

    final reviewRef =
    _firestore.collection('MovieReviews').doc();

    await reviewRef.set({
      'reviewId': reviewRef.id,
      'movieId': results.movieId,
      'movieName': results.movieName,
      'userId': user.uid,
      'username': results.author,
      'content': results.content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<MovieReviewResults>> fetchReviews(int movieId) {
    return _firestore
        .collection('MovieReviews')
        .where('movieId', isEqualTo: movieId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MovieReviewResults(
          id: doc['reviewId'],
          movieId: doc['movieId'],
          movieName: doc['movieName'],
          author: doc['username'],
          content: doc['content'],
          createdAt:
          (doc['createdAt'] as Timestamp?)?.toDate(),
        );
      }).toList();
    });
  }
}
