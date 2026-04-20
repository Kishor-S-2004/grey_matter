import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/seriesWatchList_repository.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_event.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_state.dart';

import '../../../api_service/tv_show_apiservice.dart';
import '../../../repositories/favMovie_repositories.dart';
import '../../../repositories/series_repositories.dart';
import '../../../viewmodel/bloc/credits/credits_bloc.dart';
import '../../../viewmodel/bloc/episodes/episodes_bloc.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_bloc.dart';
import '../../../viewmodel/bloc/tvShowVideo/tv_show_video_bloc.dart';
import '../../theme/appcolor.dart';
import '../movieScreen/moviedetails.dart';
import '../tvShowScreen/viewtvshow_view.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final movieRepository = MovieRepositories(MovieApiservice());
  final SeriesRepositories repositories = SeriesRepositories(
    SeriesApiService(),
  );
  @override
  void initState() {
    super.initState();
    context.read<WatchListBloc>()
      ..add(WatchListEvent.fetchSeriesFromWatchList())
      ..add(WatchListEvent.fetchMovieFromWatchList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Appcolor.primary),
        backgroundColor: Appcolor.background,
        title: Text(
          'Watch List',
          style: GoogleFonts.gabriela(
            color: Appcolor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<WatchListBloc, WatchListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.movies.isEmpty && state.series.isEmpty) {
            return const Center(
              child: Text(
                "No WatchList yet",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.movies.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Movies",
                      style: GoogleFonts.gabriela(
                        color: Appcolor.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final watchListMovies = state.movies[index];

                      final imageUrl =
                          (watchListMovies.posterPath != null &&
                              watchListMovies.posterPath!.isNotEmpty)
                          ? 'https://image.tmdb.org/t/p/w500${watchListMovies.posterPath}'
                          : 'https://via.placeholder.com/500x750?text=No+Image';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Stack(
                          children: [
                            Card(
                              elevation: 2,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: const Duration(
                                              milliseconds: 900,
                                            ),
                                            reverseTransitionDuration:
                                                const Duration(
                                                  milliseconds: 600,
                                                ),
                                            pageBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                ) => BlocProvider(
                                                  create: (context) =>
                                                      CredtisBloc(
                                                        movieRepository,
                                                      )..add(
                                                        FetchCreditDetails(
                                                          watchListMovies.id ?? 0,
                                                        ),
                                                      ),
                                                  child: BlocProvider(
                                                    create: (context) =>
                                                        FavMovieBloc(
                                                          repository:
                                                              FavMovieRepository(),
                                                        ),
                                                    child: Moviedetails(
                                                      heroTag:
                                                          'movie_${watchListMovies.id}',
                                                      movieId: watchListMovies.id ?? 0,
                                                      movieName:
                                                          watchListMovies.title ??
                                                          "Unknown",
                                                      movieGenre:
                                                          watchListMovies.genreName ??
                                                          "Unknown",
                                                      movieDescritpion:
                                                          watchListMovies.overview ??
                                                          "No overview",
                                                      posterPath: imageUrl,
                                                      releaseYear:
                                                          watchListMovies
                                                              .releaseYear ??
                                                          0,
                                                      releaseDate:
                                                          watchListMovies
                                                              .releaseYear ??
                                                          0,
                                                      voteAverage:
                                                          watchListMovies
                                                              .voteAverage ??
                                                          0.0,
                                                    ),
                                                  ),
                                                ),
                                            opaque: true,
                                            transitionsBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child,
                                                ) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag: 'movie_${watchListMovies.id}',
                                        child: Image.network(
                                          imageUrl,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      watchListMovies.title ?? "Unknown Title",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.gabriela(
                                        color: Appcolor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  context.read<WatchListBloc>().add(
                                    WatchListEvent.removeMovieFromWatchList(
                                      watchListMovies.id!,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.bookmark,
                                  color: Appcolor.primary,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],

                if (state.series.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Series",
                      style: GoogleFonts.gabriela(
                        color: Appcolor.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.series.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder: (context, index) {
                      final watchListSeries = state.series[index];

                      final imageUrl =
                          (watchListSeries.posterPath != null &&
                              watchListSeries.posterPath!.isNotEmpty)
                          ? 'https://image.tmdb.org/t/p/w500${watchListSeries.posterPath}'
                          : 'https://via.placeholder.com/500x750?text=No+Image';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    log('watchlist episodename :${watchListSeries.episodeName}');

                                    // context.read<EpisodesBloc>().add(FetchEpisodesEvent(watchListSeries.id!, watchListSeries.seasonNumber!));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              TvShowVideoBloc(repositories)
                                                ..add(
                                                  FetchTvShowVideo(
                                                    watchListSeries.id!,
                                                    watchListSeries.seasonNumber!,
                                                    watchListSeries.episodeNumber!,
                                                  ),
                                                ),
                                          child: TvShowPlayingScreen(
                                            episodeName: watchListSeries.name!,
                                            seriesId: watchListSeries.id!,
                                            seriesName: watchListSeries.name!,
                                            seasonNumber:
                                                watchListSeries.seasonNumber!,
                                            episodeNumber:
                                                watchListSeries.episodeNumber!,
                                            overview: watchListSeries.overview,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${watchListSeries.name} ${watchListSeries.overview}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.gabriela(
                                    color: Appcolor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
    ();
  }
}
