import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/viewmodel/bloc/trendingSeries/trending_series_event.dart';
import 'package:grey_matter/viewmodel/bloc/trendingSeries/trending_series_state.dart';
import 'package:meta/meta.dart';

class TrendingSeriesBloc extends Bloc<TrendingSeriesEvent, TrendingSeriesState> {
  final SeriesRepositories repositories;
  TrendingSeriesBloc(this.repositories) : super(TrendingSeriesState.initial()) {
    on<TrendingSeriesEvent>((event, emit) async{
      emit(TrendingSeriesState.loading());
      try{
        final result = await repositories.getTrendingSeries();
        emit(TrendingSeriesState.loaded(result.results));
      }catch(e,s){
        log('Error : $e');
        log('Status : $s');
        emit(TrendingSeriesState.failure('$e'));
      }
    });
  }
}
