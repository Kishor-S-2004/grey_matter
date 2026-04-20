import 'dart:developer';
import 'dart:math' hide log;

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/tvShow/seriesCast_model.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'series_credits_event.dart';
part 'series_credits_state.dart';

class SeriesCreditsBloc extends Bloc<SeriesCreditsEvent, SeriesCreditsState> {
  final SeriesRepositories repositories;
  SeriesCreditsBloc(this.repositories) : super(SeriesCreditsInitial()) {
    on<FetchSeriesCreditsEvent>((event, emit) async{
        log('Initial bloc in seriesCredits');
      // TODO: implement event handler
      emit(SeriesCreditsLoading());
      try{
        log('Try bloc in seriesCredits');
        final result = await repositories.getSeriesCredits(event.seriesId,event.seasonNumber,event.episodeNumber);
        emit(SeriesCreditsLoaded(result.cast));
        log('After try bloc in seriesCredits');

      }catch(e,s){
        log('Status : $s');
        log('Error: $e');
        emit(SeriesCreditsError('$e'));
      }
    });
  }
}
