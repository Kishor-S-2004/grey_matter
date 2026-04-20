import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/common/castDetail_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'cast_details_event.dart';
part 'cast_details_state.dart';

class CastDetailsBloc extends Bloc<CastDetailsEvent, CastDetailsState> {
  final MovieRepositories repositories;
  final SeriesRepositories Seriesrepositories;
  CastDetailsBloc(this.repositories,this.Seriesrepositories) : super(CastDetailsInitial()) {
    on<FetchCastDetailsEvent>((event, emit) async{
      emit(CastDetailsLoading());
      try{
        final result = await repositories.getCastDetails(event.personId);
        emit(CastDetailsLoaded(result));
      }catch(e,s){
        log('Error : $e');
        log('Status: $s');
        emit(CastDetailsError('$e'));
      }
    });
  }
}
