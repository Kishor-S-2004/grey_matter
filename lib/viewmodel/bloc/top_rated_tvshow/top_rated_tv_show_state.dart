part of 'top_rated_tv_show_bloc.dart';

@immutable
sealed class TopRatedTvShowState {}

final class TopRatedTvShowInitial extends TopRatedTvShowState {}

final class TopRatedTvShowLoading extends TopRatedTvShowState {}

final class TopRatedTvShowLoaded extends TopRatedTvShowState {
  final List<TopRatedSeriesResult> top_rated_result;
  TopRatedTvShowLoaded(this.top_rated_result);
}

final class TopRatedTvShowError extends TopRatedTvShowState {
  final String errorMsg;
  TopRatedTvShowError(this.errorMsg);
}
