import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grey_matter/model/common/castDetail_model.dart';
import 'package:grey_matter/model/movie/credits_model.dart';
import 'package:grey_matter/model/common/genre_model.dart';
import 'package:grey_matter/model/common/searchCast_model.dart';
import 'package:grey_matter/model/movie/movieRec_model.dart';
import 'package:grey_matter/model/movie/movieVideo_model.dart';
import 'package:grey_matter/model/tvShow/searchTvShow_model.dart';
import 'package:grey_matter/model/movie/searchmovie_model.dart';
import 'package:grey_matter/model/tvShow/top_rated_tv_show.dart';
import 'package:grey_matter/model/movie/toprated_model.dart';
import 'package:grey_matter/model/movie/upcoming_model.dart';
import 'package:http/http.dart' as http;

import '../model/movie/movie_model.dart';
import '../model/movie/movie_review.dart';
import '../model/movie/nowPlayingMovies_model.dart';

class MovieApiservice {
  final String movie_baseurl = 'https://api.themoviedb.org/3/movie/popular';
  final String genre_baseurl = 'https://api.themoviedb.org/3/genre/movie/list';
  final String upcoming_movies = 'https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=10';
  final String top_rated_movies = 'https://api.themoviedb.org/3/movie/top_rated';
  final String nowPlayingMovies = 'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=15';
  // final String credit_details = 'https://api.themoviedb.org/3/movie/{movie_id}/credits';


  // final api_access_code = dotenv.env['MOVIE_API_ACCESS_KEY'];

  Future<MovieModel> fetchMovie() async {
    final url = Uri.parse(movie_baseurl);
    log('url parsed $url');
    // log('$api_access_code');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}',
      },
    );
    // log('got the response ${response.body}');
    if (response.statusCode == 200) {
      log('response code success');
      final data = jsonDecode(response.body);
      return MovieModel.fromJson(data);
    } else {
      log('response failed : ${response.statusCode}');
      throw Exception("Can't load movies");
    }
  }

  Future<GenreModel> fetchGenre() async {
    final url = Uri.parse(genre_baseurl);
    log('genre url');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}',
      },
    );
    if (response.statusCode == 200) {
      log('genre respose success');
      final data = jsonDecode(response.body);
      return GenreModel.fromJson(data);
    } else {
      throw Exception('Cant fetch Genre : ${response.statusCode}');
    }
  }

  Future<UpcomingModel> fetchUpcomingMovies() async{
    final url = Uri.parse(upcoming_movies);
    final response = await http.get(url,headers: {
      'Authorization': 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final upComingMovies = jsonDecode(response.body);
      return UpcomingModel.fromJson(upComingMovies);
    }else{
      throw Exception('Cant fetch Upcoming movies :${response.body}');
    }
  }

  Future<TopRatedModel> fetchTopRatedMovies() async{
    final url = Uri.parse(top_rated_movies);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return TopRatedModel.fromJson(data);
    }else{
      throw Exception('Cant fetch top rated movie now');
    }
  }

  Future <Credits> fetchCreditDetails(int movieId) async{
    final credits_url = 'https://api.themoviedb.org/3/movie/$movieId/credits';
    final url = Uri.parse(credits_url);
    log('$url');
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      // log(data);
      log('${response.statusCode}');
      // log('${response.body}');
      return Credits.fromJson(data);
    }else{
      throw Exception('Cant fetch crew and cast details');
    }
  }

  Future<PlayMovie> fetchMovieVideo(int movieId) async{
    final movie_video_url = 'https://api.themoviedb.org/3/movie/$movieId/videos';
    log('${movie_video_url}');
    final url = Uri.parse(movie_video_url);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return PlayMovie.fromJson(data);
    }else{
      log('${response.statusCode} in fetchMovieVideo');
      log('${response.body} in fetchMovieVideo');
      throw Exception('Cant play video');
    }
  }

  Future<MovieReview> fetchMovieReviews(int movieId) async{
    final movie_review_url = 'https://api.themoviedb.org/3/movie/$movieId/reviews?language=en-US&page=1';
    final url = Uri.parse(movie_review_url);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return MovieReview.fromJson(data);
    }else{
      throw Exception('Cant fetch movie reviews');
    }
  }

  Future<MovieRecommendations> fetchRecommendations(int movieId) async{
    final recommendation_url = 'https://api.themoviedb.org/3/movie/$movieId/recommendations';
    log(recommendation_url);
    final url = Uri.parse(recommendation_url);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      // log('${response.body} in fetchRecommendation');
      return MovieRecommendations.fromJson(data);
    }else{
      throw Exception('Cant fetch recommendations');
    }
  }

  Future<SearchMovie> fetchSearchedMovie(String movieName) async{
    final encodedQuery = Uri.encodeQueryComponent(movieName);
    final String search_movie = 'https://api.themoviedb.org/3/search/movie?query=$encodedQuery';
    final url = Uri.parse(search_movie);
    final respoonse = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(respoonse.statusCode == 200){
      final data = jsonDecode(respoonse.body);
      log(respoonse.body);
      return SearchMovie.fromJson(data);
    }else{
      throw Exception('Cant fetch Searched Movie');
    }
  }

  Future<CastDetails> fetchCastDetails(int personId) async{
    final cast_url = 'https://api.themoviedb.org/3/person/$personId';
    final url = Uri.parse(cast_url);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return CastDetails.fromJson(json);
    }else{
      throw Exception('Cant fetch the cast details');
    }
  }

  Future<SearchCast> fetchSearchedCast(String personName) async {
    final encodedName = Uri.encodeQueryComponent(personName);
    final searchCastUrl =
        'https://api.themoviedb.org/3/search/person?query=$encodedName';

    final url = Uri.parse(searchCastUrl);
    log('$url in castsearch');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return SearchCast.fromJson(json);
    } else {
    throw Exception('Can’t fetch cast right now');
    }
  }

  Future<NowPlayingMovies> fetchNowPlayingMovie() async{
    final url = Uri.parse(nowPlayingMovies);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return NowPlayingMovies.fromJson(json);
    }else{
      throw Exception('Cant load now playing movies');
    }
  }
}
