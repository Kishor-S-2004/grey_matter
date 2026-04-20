import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/model/tvShow/seriesRecommendations_model.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/viewmodel/bloc/recommendedSeries/recommended_series_event.dart';
import 'package:grey_matter/viewmodel/bloc/recommendedSeries/recommended_series_state.dart';
import 'package:meta/meta.dart';

class RecommendedSeriesBloc
    extends Bloc<RecommendedSeriesEvent, RecommendedSeriesState> {
  final SeriesRepositories _repositories;
  RecommendedSeriesBloc(SeriesRepositories? repositories)
    : _repositories = repositories ?? SeriesRepositories(SeriesApiService()),
      super(RecommendedSeriesState.initial()) {
    on<RecommendedSeriesEvent>(_onFetchRecommendedSeries);
  }

  Future<void> _onFetchRecommendedSeries(
    RecommendedSeriesEvent event,
    Emitter<RecommendedSeriesState> emit,
  ) async {
    emit(RecommendedSeriesState.loading());
    try{
      final result = await _repositories.getRecommendedSeries(event.seriesId);
      log('${result.results.first} in Recommended Series');
      emit(RecommendedSeriesState.loaded(result.results));
    }catch(e,s){
      log('Error : $e');
      log('Status : $s');
      emit(RecommendedSeriesState.failure('$e'));
    }
  }
}
