part of 'top_rated_tv_show_bloc.dart';

@immutable
sealed class TopRatedTvShowEvent {}

class FetchTopRatedTvShowEvent extends TopRatedTvShowEvent{}