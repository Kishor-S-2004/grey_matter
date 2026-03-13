part of 'movie_bloc.dart';

// import '../../../model/movie_model.dart';

@immutable
sealed class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Result>? movies;
  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String errormsg;
  MovieError(this.errormsg);
}
