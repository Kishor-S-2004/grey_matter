import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/model/common/castDetail_model.dart';
import 'package:grey_matter/model/movie/credits_model.dart';
import 'package:grey_matter/model/common/genre_model.dart';
import 'package:grey_matter/model/common/searchCast_model.dart';
import 'package:grey_matter/model/movie/movieRec_model.dart';
import 'package:grey_matter/model/movie/movieVideo_model.dart';
import 'package:grey_matter/model/movie/movie_model.dart';
import 'package:grey_matter/model/movie/movie_review.dart';
import 'package:grey_matter/model/movie/searchmovie_model.dart';
import 'package:grey_matter/model/movie/toprated_model.dart';
import 'package:grey_matter/model/movie/upcoming_model.dart';

class MovieRepositories {
  final MovieApiservice apiService;

  MovieRepositories(this.apiService);

  Future<MovieModel> getMovies() async {
    return await apiService.fetchMovie();
  }

  Future<GenreModel> getGenre() async{
    return await apiService.fetchGenre();
  }

  Future<UpcomingModel> getUpComingMovies() async{
    return await apiService.fetchUpcomingMovies();
  }

  Future<TopRatedModel> getTopRatedMovies() async{
    return await apiService.fetchTopRatedMovies();
  }

  Future<Credits> getCreditDetails(int movieId) async{
    log('${movieId} is created');
    return await apiService.fetchCreditDetails(movieId);
  }

  Future<PlayMovie> getVideoUrl(int movieId) async{
    return await apiService.fetchMovieVideo(movieId);
  }

  Future<MovieReview> getMovieReview(int movieId) async{
    return await apiService.fetchMovieReviews(movieId);
}

Future<MovieRecommendations> getRecommendations(int movieId) async{
    return await apiService.fetchRecommendations(movieId);
}

Future<SearchMovie> getSearchedMovie(String movieName) async{
    return await apiService.fetchSearchedMovie(movieName);
}

Future<CastDetails> getCastDetails(int personId)async{
    return await apiService.fetchCastDetails(personId);
}

Future<SearchCast> getSearchedCast(String personName) async{
    return await apiService.fetchSearchedCast(personName);
}
}
