import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/movie/movie_model.dart';

part 'fav_movie_state.freezed.dart';

@freezed
class FavMovieState with _$FavMovieState{
  const factory FavMovieState.initial() = Initial;
  const factory FavMovieState.loading() = Loading;
  const factory FavMovieState.loaded(List<Result> movie) = Loaded;
  const factory FavMovieState.removed() = Removed;
  const factory FavMovieState.added() = Added;
  const factory FavMovieState.error(String error) = Failure;
}