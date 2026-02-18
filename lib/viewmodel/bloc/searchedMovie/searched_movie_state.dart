part of 'searched_movie_bloc.dart';

@immutable
sealed class SearchedMovieState {}

final class SearchedMovieInitial extends SearchedMovieState {}

final class SearchedMovieLoading extends SearchedMovieState {}

final class SearchedMovieLoaded extends SearchedMovieState {
  final List<SearchMovieResult> searchedResult;
  SearchedMovieLoaded(this.searchedResult);
}
final class SearchedMovieError extends SearchedMovieState {
  final String errorMSg;
  SearchedMovieError(this.errorMSg);
}
