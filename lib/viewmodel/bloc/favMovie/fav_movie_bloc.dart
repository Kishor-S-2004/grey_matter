import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/favMovie_repositories.dart';
import '../../../model/movie/movie_model.dart';
import 'fav_movie_event.dart';
import 'fav_movie_state.dart';

class FavMovieBloc extends Bloc<FavMovieEvent, FavMovieState> {
  final FavMovieRepository _repository;

  StreamSubscription<List<Result>>? _favSubscription;

  FavMovieBloc({FavMovieRepository? repository})
      : _repository = repository ?? FavMovieRepository(),
        super(const FavMovieState.initial()) {

    on<FetchFavMovies>(_onFetch);
    on<AddFavMovie>(_onAdd);
    on<RemoveFavMovie>(_onRemove);
    on<UpdateFavMovie>(_onUpdate);
  }

  Future<void> _onFetch(FetchFavMovies event, Emitter<FavMovieState> emit,) async {
    emit(const FavMovieState.loading());

    await _favSubscription?.cancel();

    _favSubscription = _repository.fetchFavMovies().listen((movies) {
      add(UpdateFavMovie(movies));
    });
  }

  void _onUpdate(
      UpdateFavMovie event,
      Emitter<FavMovieState> emit,
      ) {
    emit(FavMovieState.loaded(event.movie));
  }

  Future<void> _onAdd(
      AddFavMovie event,
      Emitter<FavMovieState> emit,
      ) async {
    try {
      final movieId = event.movie.id!;

      final currentMovies = state is Loaded ? (state as Loaded).movie
          : [];

      final exists = currentMovies.any((m) => m.id == movieId);

      if (exists) {
        await _repository.removeFavourite(movieId);
        emit(FavMovieState.removed());
      } else {
        await _repository.addToFavMovie(event.movie);
        emit(FavMovieState.added());
      }
    } catch (e) {
      emit(FavMovieState.error(e.toString()));
    }
  }

  Future<void> _onRemove(
      RemoveFavMovie event,
      Emitter<FavMovieState> emit,
      ) async {
    try {
      await _repository.removeFavourite(event.movieId);
    } catch (e) {
      emit(FavMovieState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _favSubscription?.cancel();
    return super.close();
  }
}