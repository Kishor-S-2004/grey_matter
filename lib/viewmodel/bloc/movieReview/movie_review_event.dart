part of 'movie_review_bloc.dart';

@immutable
sealed class MovieReviewEvent {}

class FetchMovieReview extends MovieReviewEvent{
  final int movieId;
  FetchMovieReview(this.movieId);
}
