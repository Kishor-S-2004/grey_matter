import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/nowPlayingMovies_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final MovieRepositories repositories;
  NowPlayingMoviesBloc(this.repositories) : super(NowPlayingMoviesInitial()) {
    on<FetchNowPlayingMovies>((event, emit) async{
      // TODO: implement event handler
      emit(NowPlayingMoviesLoading());
      try{
        final nowPlayingMovieResult = await repositories.getNowPlayingMovies();
        emit(NowPlayingMoviesLoaded(nowPlayingMovieResult.results));
      }catch(e,s){
        emit(NowPlayingMoviesError('Error : $e'));
        log('Error : $e');
        log('Status: $s');
      }
    });
  }
}
