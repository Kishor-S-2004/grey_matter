part of 'now_playing_movies_bloc.dart';

@immutable
sealed class NowPlayingMoviesState {}

final class NowPlayingMoviesInitial extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoaded extends NowPlayingMoviesState {
  final List<NowPlayingMovieResult>? nowPlayingMovieResult;
  NowPlayingMoviesLoaded(this.nowPlayingMovieResult);
}

final class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String errorMessage;
  NowPlayingMoviesError(this.errorMessage);
}
