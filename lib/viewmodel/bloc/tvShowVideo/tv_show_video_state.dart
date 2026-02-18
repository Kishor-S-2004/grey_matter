part of 'tv_show_video_bloc.dart';

@immutable
sealed class TvShowVideoState {}

final class TvShowVideoInitial extends TvShowVideoState {}

final class TvShowVideoLoading extends TvShowVideoState {}

final class TvShowVideoLoaded extends TvShowVideoState {
  final List<TvShowVideoResult> results;
  TvShowVideoLoaded(this.results);
}

final class TvShowVideoError extends TvShowVideoState {
  final String errorMessage;
  TvShowVideoError(this.errorMessage);
}
