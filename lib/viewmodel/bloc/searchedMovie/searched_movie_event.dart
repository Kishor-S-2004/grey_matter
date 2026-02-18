part of 'searched_movie_bloc.dart';

@immutable
sealed class SearchedMovieEvent {}

class FetchSearchedMovieEvent extends SearchedMovieEvent{
  String movieName;
  FetchSearchedMovieEvent(this.movieName);
}
