import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/movie/movie_review.dart';

part 'moviereviews_state.freezed.dart';

@freezed
class MovieReviewsState with _$MovieReviewsState{
  const factory MovieReviewsState.initial() = Initial;
  const factory MovieReviewsState.loading() = Loading;
  const factory MovieReviewsState.added() = Added;
  const factory MovieReviewsState.loaded(List<MovieReviewResults> results) = Loaded;
  const factory MovieReviewsState.failure(String error) = Failure;
}