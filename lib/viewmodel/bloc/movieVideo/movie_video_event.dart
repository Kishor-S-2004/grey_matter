part of 'movie_video_bloc.dart';

@immutable
sealed class MovieVideoEvent {}

class FetchMovieUrl extends MovieVideoEvent{
  int movieId;
  FetchMovieUrl(this.movieId);
}
