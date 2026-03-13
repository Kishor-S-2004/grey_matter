import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/movie/movie_review.dart';
part 'moviereviews_event.freezed.dart';

@freezed
class MovieReviewsEvent with _$MovieReviewsEvent{
  const factory MovieReviewsEvent.fetchReview(int movieId) = FetchReviews;
  const factory MovieReviewsEvent.addReview(MovieReviewResults result) = MovieReviews;
}