part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesEvent {}

class FetchEpisodesEvent extends EpisodesEvent{
  int seriesId;
  int seasonNumber;
  FetchEpisodesEvent(this.seriesId,this.seasonNumber);
}