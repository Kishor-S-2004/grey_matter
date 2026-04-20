import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/viewmodel/bloc/popularSeries/popular_series_event.dart';
import 'package:grey_matter/viewmodel/bloc/popularSeries/popular_series_state.dart';
import 'package:meta/meta.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final SeriesRepositories _repositories;
  PopularSeriesBloc(this._repositories): super(PopularSeriesState.initial()) {
    on<FetchPopularSeriesEvent>((event, emit) async{
     emit(PopularSeriesState.loading());
     try{
       final result = await _repositories.getPopularSeries();
       log('${result.results.length}');
       emit(PopularSeriesState.loaded(result.results));
     }catch(e,s){
       log('Error : $e');
       log('Status : $s');
       emit(PopularSeriesState.failure('$e'));
     }
    });
  }
}
