import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';

import '../../../model/movie/movie_model.dart';

part 'watch_list_event.freezed.dart';

@freezed
class WatchListEvent with _$WatchListEvent{
  const factory WatchListEvent.watchListInitial()= WatchListInitial;
  const factory WatchListEvent.addMovieToWatchList(Result movie) = AddMovieToWatchList;
  const factory WatchListEvent.removeMovieFromWatchList(int movieId) = RemoveMovieFromWatchList;
  const factory WatchListEvent.addSeriesToWatchList(AiringTodayResults series) = AddSeriesToWatchList;
  const factory WatchListEvent.removeSeriesFromWatchList(int seriesId) = RemoveSeriesFromWatchList;
  const factory WatchListEvent.fetchMovieFromWatchList() = FetchMovieFromWatchList;
  const factory WatchListEvent.fetchSeriesFromWatchList() = FetchSeriesFromWatchList;
}