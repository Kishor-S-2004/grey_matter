import 'package:flutter/material.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/model/tvShow/airing_today.dart';
import 'package:grey_matter/model/tvShow/searchTvShow_model.dart';
import 'package:grey_matter/model/tvShow/season_model.dart';
import 'package:grey_matter/model/tvShow/seriesCast_model.dart';
import 'package:grey_matter/model/tvShow/seriesRecommendations_model.dart';
import 'package:grey_matter/model/tvShow/top_rated_tv_show.dart';
import 'package:grey_matter/model/tvShow/tvShowVideo_model.dart';

import '../model/tvShow/episode_list.dart';

class SeriesRepositories {
 final SeriesApiService apiService;
  SeriesRepositories(this.apiService);

  Future<Tvshow> getSeriesDetails()async{
    return await apiService.fetchTopRatedSeries();
  }

  Future<AiringToday> getAiringTodayDetails() async{
    return await apiService.fetchAiringTodaySeries();
  }

  Future<Season> getSeriesSeasons(int seriesId) async{
    return await apiService.fetchSeriesSeason(seriesId);
  }

  Future<Episode> getEpisodeList(int seriesId,int seasonNumber) async{
    return await apiService.fetchEpisodelist(seriesId, seasonNumber);
  }

  Future<SearchTvShow> getSearchedTvShow(String tvShowName) async{
    return await apiService.fetchSearchedTvShow(tvShowName);
  }

  Future<TvShowVideo> getTvShowVideo(int seriesId,int seasonNumber, int episodeNumber) async{
    return await apiService.fetchTvShowVideo(seriesId,seasonNumber,episodeNumber);
  }

  Future<SeriesCredits> getSeriesCredits(int seriesId,int seasonNumber,int episodeNumber) async{
    return await apiService.fetchSeriesCredits(seriesId,seasonNumber,episodeNumber);
  }

  Future<SeriesRecommendations> getRecommendedSeries(int seriesId)async{
    return await apiService.fetchRecommendedSeries(seriesId);
  }
}