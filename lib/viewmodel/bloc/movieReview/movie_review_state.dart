part of 'movie_review_bloc.dart';

@immutable
sealed class MovieReviewState {}

final class MovieReviewInitial extends MovieReviewState {}

final class MovieReviewLoading extends MovieReviewState {}

final class MovieReviewLoaded extends MovieReviewState {
  final List<MovieReviewResuts> reviewResult;
  MovieReviewLoaded(this.reviewResult);
}

final class MovieReviewError extends MovieReviewState {
  final String errorMsg;
  MovieReviewError(this.errorMsg);
}
