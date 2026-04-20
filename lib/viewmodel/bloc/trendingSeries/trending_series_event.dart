import 'package:freezed_annotation/freezed_annotation.dart';

part 'trending_series_event.freezed.dart';

@freezed
class TrendingSeriesEvent with _$TrendingSeriesEvent{
  const factory TrendingSeriesEvent.fetchTrendingSeries() = FetchTrendingSeries;
}