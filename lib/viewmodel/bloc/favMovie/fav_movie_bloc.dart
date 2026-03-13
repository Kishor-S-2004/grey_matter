import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/favMovie_repositories.dart';
import 'fav_movie_event.dart';
import 'fav_movie_state.dart';

class FavMovieBloc extends Bloc<FavMovieEvent, FavMovieState> {
  final FavMovieRepository _repository;

  FavMovieBloc({FavMovieRepository? repository})
      : _repository = repository ?? FavMovieRepository(),
        super(const FavMovieState.initial()) {

    on<FetchFavMovies>(_onFetch);
    on<AddFavMovie>(_onAdd);
  }

  Future<void> _onFetch(
      FetchFavMovies event,
      Emitter<FavMovieState> emit,
      ) async {
    emit(const FavMovieState.loading());
    try {
      final movies = await _repository.fetchFavMovies();
      emit(FavMovieState.loaded(movies));
    } catch (e) {
      emit(FavMovieState.error(e.toString()));
    }
  }

  Future<void> _onAdd(
      AddFavMovie event,
      Emitter<FavMovieState> emit,
      ) async {
    try {
      emit(const FavMovieState.loading());

      final movieId = event.movie.id!;

      final isFav = await _repository.fetchFavMovies();

      final exists = isFav.any(
            (movie) => movie.id == event.movie.id,
      );

      if (exists) {
        await _repository.removeFavourite(movieId);
        emit(FavMovieState.removed());
      } else {
        await _repository.addToFavMovie(event.movie);
        emit(FavMovieState.added());
      }

      final updatedMovies = await _repository.fetchFavMovies();

      emit(FavMovieState.loaded(updatedMovies));
    } catch (e) {
      emit(FavMovieState.error(e.toString()));
    }
  }
}