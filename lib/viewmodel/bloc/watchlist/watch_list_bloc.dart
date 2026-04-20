import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/seriesWatchList_repository.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_event.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_state.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  final WatchlistRepository _repository;

  WatchListBloc(WatchlistRepository? repository)
      : _repository = repository ?? WatchlistRepository(),
        super(const WatchListState()) {

    on<WatchListInitial>((event, emit) {
      emit(state.copyWith(
        movies: [],
        series: [],
        isLoading: false,
        error: null,
      ));
    });

    on<AddMovieToWatchList>(_onAddMovie);
    on<RemoveMovieFromWatchList>(_onRemoveMovie);
    on<FetchMovieFromWatchList>(_onFetchMovies);

    on<AddSeriesToWatchList>(_onAddSeries);
    on<RemoveSeriesFromWatchList>(_onRemoveSeries);
    on<FetchSeriesFromWatchList>(_onFetchSeries);

  }

  Future<void> _onAddMovie(
      AddMovieToWatchList event,
      Emitter<WatchListState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await _repository.addToWatchListMovie(event.movie);

      final movies = await _repository.fetchWatchListMovies();

      emit(state.copyWith(
        movies: movies.toList(),
        isLoading: false,
      ));
    } catch (e, s) {
      log('AddMovie Error: $e');
      log('Stack: $s');

      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onRemoveMovie(
      RemoveMovieFromWatchList event,
      Emitter<WatchListState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await _repository.removeFromWatchListMovie(event.movieId);

      final movies = await _repository.fetchWatchListMovies();

      emit(state.copyWith(
        movies: movies,
        isLoading: false,
      ));
    } catch (e, s) {
      log('RemoveMovie Error: $e');
      log('Stack: $s');

      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onFetchMovies(
      FetchMovieFromWatchList event,
      Emitter<WatchListState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final movies = await _repository.fetchWatchListMovies();

      emit(state.copyWith(
        movies: movies,
        isLoading: false,
      ));
    } catch (e, s) {
      log('FetchMovies Error: $e');
      log('Stack: $s');

      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onAddSeries(
      AddSeriesToWatchList event,
      Emitter<WatchListState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await _repository.addToWatchListSeries(event.series);

      final series = await _repository.fetchWatchListSeries();

      emit(state.copyWith(
        series: series,
        isLoading: false,
      ));
    } catch (e, s) {
      log('AddSeries Error: $e');
      log('Stack: $s');

      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onRemoveSeries(
      RemoveSeriesFromWatchList event,
      Emitter<WatchListState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      await _repository.removeFromWatchListSeries(event.seriesId);

      final series = await _repository.fetchWatchListSeries();

      emit(state.copyWith(
        series: series,
        isLoading: false,
      ));
    } catch (e, s) {
      log('RemoveSeries Error: $e');
      log('Stack: $s');

      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  Future<void> _onFetchSeries(
      FetchSeriesFromWatchList event,
      Emitter<WatchListState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final series = await _repository.fetchWatchListSeries();

      emit(state.copyWith(
        series: series,
        isLoading: false,
      ));
    } catch (e, s) {
      log('FetchSeries Error: $e');
      log('Stack: $s');

      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }
}