part of 'genre_bloc.dart';

@immutable
sealed class GenreState {}

final class GenreInitial extends GenreState {}

final class GenreLoading extends GenreState{}

final class GenreLoaded extends GenreState{
  // final int genreId;
  // final String genreName;
  final GenreModel genres;
  GenreLoaded(this.genres);
}

final class GenreError extends GenreState{
  final String errormsg;
  GenreError(this.errormsg);
}
