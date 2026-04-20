part of 'series_credits_bloc.dart';

@immutable
sealed class SeriesCreditsEvent {}

class FetchSeriesCreditsEvent extends SeriesCreditsEvent{
  final int seriesId;
  final int seasonNumber;
  final int episodeNumber;
  FetchSeriesCreditsEvent(this.seriesId,this.seasonNumber,this.episodeNumber);
}
