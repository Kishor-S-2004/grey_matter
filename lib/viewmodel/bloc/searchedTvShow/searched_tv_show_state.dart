part of 'searched_tv_show_bloc.dart';

@immutable
sealed class SearchedTvShowState {}

final class SearchedTvShowInitial extends SearchedTvShowState {}

final class SearchedTvShowLoading extends SearchedTvShowState {}

final class SearchedTvShowLoaded extends SearchedTvShowState {
  final List<SearchTvShowResult> tvShowResult;
  SearchedTvShowLoaded(this.tvShowResult);
}

final class SearchedTvShowError extends SearchedTvShowState {
  final String errorMsg;
  SearchedTvShowError(this.errorMsg);
}
