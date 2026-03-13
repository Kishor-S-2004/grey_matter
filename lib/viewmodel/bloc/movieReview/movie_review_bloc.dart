import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/movie_review.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'movie_review_event.dart';
part 'movie_review_state.dart';

class MovieReviewBloc extends Bloc<MovieReviewEvent, MovieReviewState> {
  final MovieRepositories repositories;
  MovieReviewBloc(this.repositories) : super(MovieReviewInitial()) {
    on<FetchMovieReview>((event, emit) async{
      log('${event.movieId} Started');

      // TODO: implement event handler
      emit(MovieReviewLoading());
      try{
        log('${event.movieId} in ReviewBloc');
        final reviewResult = await repositories.getMovieReview(event.movieId);
        emit(MovieReviewLoaded(reviewResult.results));
      }catch(e,s){
        log('Status: $s');
        log('Error: $e');
        emit(MovieReviewError('$e'));
      }
    });
  }
}
