import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/common/searchCast_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:meta/meta.dart';

part 'search_cast_event.dart';
part 'search_cast_state.dart';

class SearchCastBloc extends Bloc<SearchCastEvent, SearchCastState> {
  final MovieRepositories movieRepositories;
  final SeriesRepositories seriesRepositories;
  SearchCastBloc(this.movieRepositories,this.seriesRepositories) : super(SearchCastInitial()) {
    on<FetchSearchCastEvent>((event, emit) async {
      log('Initial block in searchCast');
      // TODO: implement event handler
      emit(SearchCastLoading());
      try {
        final response = await movieRepositories.getSearchedCast(event.personName);

        if (response.results.isNotEmpty) {
          final knownForList = response.results.first.knownFor;
          emit(SearchCastLoaded(knownForList));
          log('Loaded ${knownForList.length} knownFor items');
        } else {
          emit(SearchCastLoaded([]));
          log('No cast found');
        }
      } catch(e,s){
        log('Status :$s');
        log('Error :$e');
        emit(SearchCastError('$e'));
      }
    });
  }
}
