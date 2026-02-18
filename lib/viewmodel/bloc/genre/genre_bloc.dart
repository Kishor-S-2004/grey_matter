import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

import '../../../model/common/genre_model.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final MovieRepositories genreRepositories;
  GenreBloc(this.genreRepositories) : super(GenreInitial()) {
    log('Fetched Genre');
    on<FetchGenre>((event, emit) async {
      emit(GenreLoading());
      try{
        final GenreModel genreModel = await genreRepositories.getGenre();
        // log('Genres fetched: ${genreModel.name}');
        emit(GenreLoaded(genreModel));
      }catch(e){
        emit(GenreError('${e.toString()}'));
      }
    });
  }
}
