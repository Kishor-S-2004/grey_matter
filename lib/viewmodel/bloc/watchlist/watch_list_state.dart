  import 'package:freezed_annotation/freezed_annotation.dart';
  import 'package:grey_matter/model/movie/movie_model.dart';
  import 'package:grey_matter/model/tvShow/airing_today.dart';

  part 'watch_list_state.freezed.dart';

  @freezed
  class WatchListState with _$WatchListState {
    const factory WatchListState({
      @Default([]) List<Result> movies,
      @Default([]) List<AiringTodayResults> series,
      @Default(false) bool isLoading,
      String? error,
    }) = WatchList;
  }