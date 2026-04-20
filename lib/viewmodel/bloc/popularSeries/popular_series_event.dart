import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_series_event.freezed.dart';

@freezed
class PopularSeriesEvent with _$PopularSeriesEvent{
  const factory PopularSeriesEvent.fetchPopularSeries() = FetchPopularSeriesEvent;
}