part of 'movie_recommendation_bloc.dart';

@immutable
sealed class MovieRecommendationState {}

final class MovieRecommendationInitial extends MovieRecommendationState {}

final class MovieRecommendationLoading extends MovieRecommendationState {}

final class MovieRecommendationLoaded extends MovieRecommendationState {
  List<RecommendationResult> results;
  MovieRecommendationLoaded(this.results);
}

final class MovieRecommendationError extends MovieRecommendationState {
  final String errorMsg;
  MovieRecommendationError(this.errorMsg);
}
