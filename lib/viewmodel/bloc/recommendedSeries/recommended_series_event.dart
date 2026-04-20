import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommended_series_event.freezed.dart';

@freezed
class RecommendedSeriesEvent with _$RecommendedSeriesEvent{
  const factory RecommendedSeriesEvent.fetchRecommendedSeries(int seriesId) = RecommendedSeries;
}