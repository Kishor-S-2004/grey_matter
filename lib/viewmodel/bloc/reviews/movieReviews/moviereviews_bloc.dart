import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:grey_matter/repositories/movieReview_repo.dart';
import 'package:meta/meta.dart';

import 'moviereviews_event.dart';
import 'moviereviews_state.dart';

class MoviereviewsBloc extends Bloc<MovieReviewsEvent, MovieReviewsState> {
  final MovieReviewRepo _movieReviewRepo;
  MoviereviewsBloc(MovieReviewRepo? movieReviewRepo) : _movieReviewRepo = movieReviewRepo ?? MovieReviewRepo(),super(MovieReviewsState.initial()) {
    on<MovieReviews>(_onAddMovieReviews);
    on<FetchReviews>(_onFetchReviews);
  }

  Future _onAddMovieReviews(MovieReviews event,Emitter<MovieReviewsState> emit) async{
    emit(MovieReviewsState.loading());

    try{
      await _movieReviewRepo.addReviews(event.result);
      emit(MovieReviewsState.added());
    }catch (e,s){
      log('Error : $e');
      log('Status : $s');
      emit(MovieReviewsState.failure('$e'));
    }
  }

  Future<void> _onFetchReviews(
      FetchReviews event,
      Emitter<MovieReviewsState> emit,
      ) async {
    emit(const MovieReviewsState.loading());

    try {
      await emit.forEach(
        _movieReviewRepo.fetchReviews(event.movieId),
        onData: (reviews) => Loaded(reviews),
      );
    } catch (e) {
      emit(MovieReviewsState.failure('$e'));
    }
  }

}
