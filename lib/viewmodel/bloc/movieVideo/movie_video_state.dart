part of 'movie_video_bloc.dart';

@immutable
sealed class MovieVideoState {}

final class MovieVideoInitial extends MovieVideoState {}

final class MovieVideoLoading extends MovieVideoState {}

final class MovieVideoLoaded extends MovieVideoState {
  final List<MovieVideoResults> result;
  MovieVideoLoaded(this.result);
}

final class MovieVideoError extends MovieVideoState {
  final String errorMsg;
  MovieVideoError(this.errorMsg);
}
