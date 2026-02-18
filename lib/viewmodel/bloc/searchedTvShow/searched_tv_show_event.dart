part of 'searched_tv_show_bloc.dart';

@immutable
sealed class SearchedTvShowEvent {}

class FetchSearchedTvShowEvent extends SearchedTvShowEvent{
  final String tvShowName;
  FetchSearchedTvShowEvent(this.tvShowName);
}
