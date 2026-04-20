import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/movie/movie_model.dart';

part 'fav_movie_event.freezed.dart';

@freezed
class FavMovieEvent with _$FavMovieEvent{
  const factory FavMovieEvent.fetchFavMovies() = FetchFavMovies;

  const factory FavMovieEvent.addFavMovie(Result movie) = AddFavMovie;
  const factory FavMovieEvent.updateFavMovie(List<Result> movie) = UpdateFavMovie;

  const factory FavMovieEvent.removeFavMovie(int movieId) = RemoveFavMovie;
}