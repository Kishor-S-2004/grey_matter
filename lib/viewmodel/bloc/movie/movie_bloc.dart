import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:grey_matter/model/movie/movie_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
// import 'package:meta/meta.dart';

part 'movie_state.dart';
part 'movie_event.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepositories repositories;

  MovieBloc(this.repositories) : super(MovieInitial()) {
    on<FetchMovieDetails>((event, emit) async {
      emit(MovieLoading());
      try {
        final movieModel = await repositories.getMovies();
        emit(MovieLoaded(movieModel.results));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}

