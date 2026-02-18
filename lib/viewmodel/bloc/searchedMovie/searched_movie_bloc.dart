import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/searchmovie_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'searched_movie_event.dart';
part 'searched_movie_state.dart';

class SearchedMovieBloc extends Bloc<SearchedMovieEvent, SearchedMovieState> {
  final MovieRepositories repositories;
  SearchedMovieBloc(this.repositories) : super(SearchedMovieInitial()) {
    // log('initiated in search');
    on<FetchSearchedMovieEvent>((event, emit) async{

      // TODO: implement event handler
      emit(SearchedMovieLoading());
      try{
        // log('Try Block IN SearchedMovie');
        final searchedMovieResult = await repositories.getSearchedMovie(event.movieName);
        // log('${searchedMovieResult.results} in SearchedMovie');
        emit(SearchedMovieLoaded(searchedMovieResult.results));
      }catch(e,s){
        log('Status : $s');
        emit(SearchedMovieError('$e'));
      }
    });
  }
}
