import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/tvShow/top_rated_tv_show.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'top_rated_tv_show_event.dart';
part 'top_rated_tv_show_state.dart';

class TopRatedTvShowBloc extends Bloc<TopRatedTvShowEvent, TopRatedTvShowState> {
  final SeriesRepositories repositories;
  TopRatedTvShowBloc(this.repositories) : super(TopRatedTvShowInitial()) {
    on<FetchTopRatedTvShowEvent>((event, emit) async{
      log('Initiated');
      emit(TopRatedTvShowLoading());
      try{
        log('Try Block');
        final Tvshow topRatedResult = await repositories.getSeriesDetails();
        // log('${topRatedResult.results}');
        emit(TopRatedTvShowLoaded(topRatedResult.results));
      }catch (e ,s){
        log('Status : $s');
        log('Error : $e');
        emit(TopRatedTvShowError('$e'));
      }
    });
  }
}
