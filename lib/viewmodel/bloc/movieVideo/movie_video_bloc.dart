import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/movieVideo_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'movie_video_event.dart';
part 'movie_video_state.dart';

class MovieVideoBloc extends Bloc<MovieVideoEvent, MovieVideoState> {
  final MovieRepositories repositories;
  MovieVideoBloc(this.repositories) : super(MovieVideoInitial()) {
    on<FetchMovieUrl>((event, emit) async{
     emit(MovieVideoLoading());
     try{
       final movieVideoResult = await repositories.getVideoUrl(event.movieId);
       log('${movieVideoResult.id}');
       log('Video Fetched');
       emit(MovieVideoLoaded(movieVideoResult.results));
     }catch (e,s){
       log('Status:$s');
       emit(MovieVideoError('Error Loading Video:$e'));
     }
    });
  }
}
