import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'airingtoday_event.dart';
part 'airingtoday_state.dart';

class AiringtodayBloc extends Bloc<AiringtodayEvent, AiringtodayState> {
  final SeriesRepositories repositories;
  AiringtodayBloc(this.repositories) : super(AiringtodayInitial()) {
    on<FetchAiringTodaySeries>((event, emit) async{
      emit(AiringtodayLoading());
      try{
        final airingTodayResult = await repositories.getAiringTodayDetails();
        emit(AiringtodayLoaded(airingTodayResult.results));
      }catch(e,s){
        log('Status : $s');
        log('Error :$e');
        emit(AiringtodayError('$e'));
      }
    });
  }
}
