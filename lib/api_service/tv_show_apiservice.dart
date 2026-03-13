import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';
import 'package:grey_matter/model/tvShow/episode_list.dart';
import 'package:grey_matter/model/tvShow/season_model.dart';
import 'package:grey_matter/model/tvShow/seriesCast_model.dart';
import 'package:grey_matter/model/tvShow/seriesRecommendations_model.dart';
import 'package:grey_matter/model/tvShow/tvShowVideo_model.dart';
import 'package:http/http.dart' as http;

import '../model/tvShow/searchTvShow_model.dart';
import '../model/tvShow/top_rated_tv_show.dart';

class SeriesApiService {
  final String series_top_rated = 'https://api.themoviedb.org/3/tv/top_rated';
  final String airing_today = 'https://api.themoviedb.org/3/tv/airing_today?language=en-US&page=3';

  Future<Tvshow> fetchTopRatedSeries() async {
    final url = Uri.parse(series_top_rated);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('${response.statusCode} of tv show');
      // log('${response.body} of tv show');
      return Tvshow.fromJson(data);
    } else {
      throw Exception('Cant fetch series');
    }
  }

  Future<AiringToday> fetchAiringTodaySeries()async{
    final url = Uri.parse(airing_today);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return AiringToday.fromJson(data);
    }else{
      throw Exception('Cant fetch airing today tv shows');
    }
  }

  Future<Season> fetchSeriesSeason(int seriesId) async{
    final String series_season = 'https://api.themoviedb.org/3/tv/$seriesId';
    final url = Uri.parse(series_season);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return Season.fromJson(data);
    }else{
      throw Exception('Error fetching Seasons');
    }
  }

  Future<Episode> fetchEpisodelist(int seriesId,int seasonNumber) async{
    // log('${seriesId} in API call');
    // log('${seasonNumber} in API call');
    final episode_list_url = 'https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber';
    final url = Uri.parse(episode_list_url);

    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });
    print("FINAL URL => $url");

    // print("STATUS CODE: ${response.statusCode}");
    // print("RESPONSE BODY: ${response.body}");

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return Episode.fromJson(data);
    }else{
      log('${response.statusCode}');
      // log('${response.body}');
      throw Exception('Error fetching episodes , Status: ${response.statusCode} | ');

    }
  }

  Future<SearchTvShow> fetchSearchedTvShow(String tvShowName) async{
    final encodedName = Uri.encodeQueryComponent(tvShowName);
    final searchTvShow = 'https://api.themoviedb.org/3/search/tv?query=$tvShowName';
    final url = Uri.parse(searchTvShow);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode ==200){
      final data = jsonDecode(response.body);
      return SearchTvShow.fromJson(data);
    }else{
      throw Exception('Cant fetch the tv show');
    }
  }

  Future<TvShowVideo> fetchTvShowVideo(int seriesId,int seasonNumber,int episodeNumber)async{
    final tvShowVideoUrl = 'https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/videos';
    log('${tvShowVideoUrl} in fetch tvshow video');
    // final tvShowVideoUrl = 'https://api.themoviedb.org/3/tv/$seriesId/videos';
    final url = Uri.parse(tvShowVideoUrl);
    final response = await http.get(url,headers: {
      'Authorization'  : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode == 200){
      // log('${response.body}');
      final json = jsonDecode(response.body);
      return TvShowVideo.fromJson(json);
    }else{
      throw Exception('Cant load the video');
    }
  }

  Future<SeriesCredits> fetchSeriesCredits(int seriesId,int seasonNumber,int episodeNumber) async{
    final seriesCreditsUrl = 'https://api.themoviedb.org/3/tv/$seriesId/season/$seasonNumber/episode/$episodeNumber/credits';
    final url = Uri.parse(seriesCreditsUrl);
    log('$url');
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return SeriesCredits.fromJson(json);
    }else{
      throw Exception('Cant fetch Credits of the series');
    }
  }

  Future<SeriesRecommendations> fetchRecommendedSeries(int seriesId) async{
    final base_url = 'https://api.themoviedb.org/3/tv/$seriesId/recommendations';
    final url = Uri.parse(base_url);
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${dotenv.env['MOVIE_API_ACCESS_KEY']}'
    });

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return SeriesRecommendations.fromJson(json);
    }else{
      throw Exception('Cant fetch Recommended Tv Shows');
    }
  }
}
