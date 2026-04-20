part of 'tv_show_video_bloc.dart';

@immutable
sealed class TvShowVideoEvent {}

class FetchTvShowVideo extends TvShowVideoEvent{
  final int seriesId;
  final int seasonNumber;
  final int episodeNumber;
  FetchTvShowVideo(this.seriesId,this.seasonNumber,this.episodeNumber);
}