part of 'genre_bloc.dart';

@immutable
sealed class GenreEvent {}

final class FetchGenre extends GenreEvent{}