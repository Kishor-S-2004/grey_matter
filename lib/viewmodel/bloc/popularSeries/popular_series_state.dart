import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';

part 'popular_series_state.freezed.dart';

@freezed
class PopularSeriesState with _$PopularSeriesState{
  const factory PopularSeriesState.initial() = PopularSeriesInitial;
  const factory PopularSeriesState.loading() = PopularSeriesLoading;
  const factory PopularSeriesState.loaded(List<AiringTodayResults> results) = PopularSeriesLoaded;
  const factory PopularSeriesState.failure(String errorMsg) = PopularSeriesFailure;
}