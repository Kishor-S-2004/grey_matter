import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/tvShow/tvShowVideo_model.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'tv_show_video_event.dart';
part 'tv_show_video_state.dart';

class TvShowVideoBloc extends Bloc<TvShowVideoEvent, TvShowVideoState> {
  final SeriesRepositories repositories;
  TvShowVideoBloc(this.repositories) : super(TvShowVideoInitial()) {
    on<FetchTvShowVideo>((event, emit) async{
      // TODO: implement event handler
      emit(TvShowVideoLoading());
      try{
        final results = await repositories.getTvShowVideo(event.seriesId,event.seasonNumber,event.episodeNumber);
        log('${results.results}');
        emit(TvShowVideoLoaded(results.results));
      }catch(e,s){
        log('Error : $e');
        log('Status : $s');
        emit(TvShowVideoError('$e'));
      }
    });
  }
}

