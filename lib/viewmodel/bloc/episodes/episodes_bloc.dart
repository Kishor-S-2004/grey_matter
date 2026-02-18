import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

import '../../../model/tvShow/episode_list.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final SeriesRepositories repositories;
  EpisodesBloc(this.repositories) : super(EpisodesInitial()) {
    on<FetchEpisodesEvent>((event, emit) async{
      emit(EpisodesLoading());
      try{
        // log('start');
        final episodeList = await repositories.getEpisodeList(event.seriesId, event.seasonNumber);
        // log('${event.seriesId}');
        // log('${event.seasonNumber}');
        // log('${episodeList}');
        emit(EpisodesLoaded(episodeList.episodes));
      }catch(e,s){
        log('Status : $s');
        log('Error : $e');
        emit(EpisodesError('$e'));
      }
    });
  }
}
