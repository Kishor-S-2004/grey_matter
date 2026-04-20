import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';

part 'trending_series_state.freezed.dart';

@freezed
class TrendingSeriesState with _$TrendingSeriesState{
  const factory TrendingSeriesState.initial() = TrendingSeriesInitial;
  const factory TrendingSeriesState.loading() = TrendingSeriesLoading;
  const factory TrendingSeriesState.loaded(List<AiringTodayResults> results) = TrendingSeriesLoaded;
  const factory TrendingSeriesState.failure(String errorMsg) = TrendingSeriesFailure;
}