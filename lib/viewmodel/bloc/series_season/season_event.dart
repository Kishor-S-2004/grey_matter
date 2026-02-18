part of 'season_bloc.dart';

@immutable
sealed class SeasonEvent {}

class FetchSeriesSeasons extends SeasonEvent{
  int seriesId;
  FetchSeriesSeasons(this.seriesId);
}
