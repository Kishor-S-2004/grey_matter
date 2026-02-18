import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/movieRec_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final MovieRepositories repositories ;
  MovieRecommendationBloc(this.repositories) : super(MovieRecommendationInitial()) {
    on<FetchMovieRecommendations>((event, emit) async{
      // TODO: implement event handler
      emit(MovieRecommendationLoading());
      try{
        final recommendation_result = await repositories.getRecommendations(event.movieId);
        // log('Recommendation result :${event.movieId}');
        // log('Recommendation result :${recommendation_result.results}');
        emit(MovieRecommendationLoaded(recommendation_result.results));
      }catch(e,s){
        log('Error :$e');
        log('Status :$s');
        emit(MovieRecommendationError('Error fetching : $e'));
      }
    });
  }
}
