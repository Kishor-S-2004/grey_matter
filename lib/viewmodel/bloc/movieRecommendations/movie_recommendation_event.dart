part of 'movie_recommendation_bloc.dart';

@immutable
sealed class MovieRecommendationEvent {}

class FetchMovieRecommendations extends MovieRecommendationEvent{
  int movieId;
  FetchMovieRecommendations(this.movieId);
}
