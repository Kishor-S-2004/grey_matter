import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/tvShow/searchTvShow_model.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'searched_tv_show_event.dart';
part 'searched_tv_show_state.dart';

class SearchedTvShowBloc extends Bloc<SearchedTvShowEvent, SearchedTvShowState> {
  final SeriesRepositories repositories;
  SearchedTvShowBloc(this.repositories) : super(SearchedTvShowInitial()) {
    on<FetchSearchedTvShowEvent>((event, emit) async{
      // TODO: implement event handler
      emit(SearchedTvShowLoading());
      try{
        final result = await repositories.getSearchedTvShow(event.tvShowName);
        emit(SearchedTvShowLoaded(result.results));
      }catch(e,s){
        log('Error:$e');
        log('Status:$s');
        emit(SearchedTvShowError("$e"));
      }
    });
  }
}
