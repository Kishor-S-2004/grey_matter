import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

import '../../../model/tvShow/season_model.dart';

part 'season_event.dart';
part 'season_state.dart';

class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
  final SeriesRepositories repositories;
  SeasonBloc(this.repositories) : super(SeasonInitial()) {
    on<FetchSeriesSeasons>((event, emit) async{
      emit(SeasonLoading());
      try{
        final seriesSeason = await repositories.getSeriesSeasons(event.seriesId);
        emit(SeasonLoaded(seriesSeason.seasons!));
      }catch(e,s){
        log('Error : $e');
        log('Status : $s');
        emit(SeasonError('$e'));
      }
    });
  }
}
