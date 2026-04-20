import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/tvShow/seriesRecommendations_model.dart';

part 'recommended_series_state.freezed.dart';

@freezed
class RecommendedSeriesState with _$RecommendedSeriesState{
  const factory RecommendedSeriesState.initial() = RecommendedSeriesInitial;
  const factory RecommendedSeriesState.loading() = RecommendedSeriesLoading;
  const factory RecommendedSeriesState.loaded(List<SeriesRecommendationResult> result) = RecommendedSeriesLoaded;
  const factory RecommendedSeriesState.failure(String error) = RecommendedSeriesFailure;
}