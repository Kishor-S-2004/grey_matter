part of 'topratedmovies_bloc.dart';

@immutable
sealed class TopratedmoviesState {}

final class TopratedmoviesInitial extends TopratedmoviesState {}

final class TopratedmoviesLoading extends TopratedmoviesState {}

final class TopratedmoviesLoaded extends TopratedmoviesState {
  final List<TopRatedMovieResult> movies;
  TopratedmoviesLoaded(this.movies);
}

final class TopratedmoviesError extends TopratedmoviesState {
  final String errorMsg;
  TopratedmoviesError(this.errorMsg);
}
