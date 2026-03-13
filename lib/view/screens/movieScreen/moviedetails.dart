import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/model/movie/movie_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/screens/castDetails_view.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/view/widgets/movie_details_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/credits/credits_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/favMovie/fav_movie_event.dart';

import '../../../api_service/tv_show_apiservice.dart';
import '../../../viewmodel/bloc/castDetails/cast_details_bloc.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_bloc.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_state.dart';
import '../../../viewmodel/bloc/movieReview/movie_review_bloc.dart';
import '../../../viewmodel/bloc/movieVideo/movie_video_bloc.dart';
import '../../../viewmodel/bloc/watchlist/watch_list_bloc.dart';
import '../../../viewmodel/bloc/watchlist/watch_list_event.dart';
import '../../../viewmodel/bloc/watchlist/watch_list_state.dart';
import 'movieplayingscreen.dart';

class Moviedetails extends StatefulWidget {
  final int movieId;
  final String movieName;
  final String movieGenre;
  final String movieDescritpion;
  final String posterPath;
  final int? releaseDate;
  final double voteAverage;

  Moviedetails({
    super.key,
    required this.movieId,
    required this.movieName,
    required this.movieGenre,
    required this.movieDescritpion,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  State<Moviedetails> createState() => _MoviedetailsState();
}

class _MoviedetailsState extends State<Moviedetails> {

  @override
  void initState() {
    super.initState();

    context.read<FavMovieBloc>().add(FetchFavMovies());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final MovieRepositories repositories = MovieRepositories(MovieApiservice());
    final SeriesRepositories Seriesrepositories = SeriesRepositories(
      SeriesApiService(),
    );
    // CredtisBloc credtisBloc = CredtisBloc(repositories.getCreditDetails(widget.movieId) as MovieRepositories);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 15),
          SizedBox(
            height: screenHeight * 0.8,
            width: double.infinity,
            child: Opacity(
              opacity: 0.12,
              child: Image.network(widget.posterPath, fit: BoxFit.fill),
            ),
          ),

          /// 🔹 FOREGROUND (SCROLLABLE)
          BlocBuilder<CredtisBloc, CredtisState>(
            builder: (context, state) {
              if (state is CredtisLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    /// Movie Name
                    Center(
                      child: CustomText(
                        text: widget.movieName,
                        fW: FontWeight.bold,
                        fS: 20,
                      ),
                    ),

                    /// Poster
                    AspectRatio(
                      aspectRatio: 1.6,
                      child: GestureDetector(
                        onTap: () {
                          log('${widget.movieId} movie Id for yt');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    MovieVideoBloc(repositories)
                                      ..add(FetchMovieUrl(widget.movieId)),
                                child: MoviePlayingScreen(
                                  movieId: widget.movieId,
                                  moviename: widget.movieName,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Image.network(widget.posterPath),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// Release Date | Genre
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: widget.releaseDate.toString(),
                          fW: FontWeight.bold,
                          fS: 13,
                        ),
                        const SizedBox(width: 8),
                        Container(width: 1, height: 14, color: Colors.grey),
                        const SizedBox(width: 8),
                        CustomText(
                          text: widget.movieGenre,
                          fW: FontWeight.bold,
                          fS: 13,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 4),
                        CustomText(
                          text: widget.voteAverage.toStringAsFixed(1),
                          fW: FontWeight.bold,
                          fS: 15,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    /// Story Line
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomText(
                        text: 'Story Line',
                        fW: FontWeight.bold,
                        fS: 20,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.movieDescritpion,
                        style: GoogleFonts.gabriela(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Cast Section
                    if (state is CredtisLoaded) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomText(
                          text: 'Cast',
                          fW: FontWeight.bold,
                          fS: 20,
                        ),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.casts.length,
                          itemBuilder: (context, index) {
                            final cast = state.casts[index];
                            // final castDepartment = cast.knownForDepartment;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: InkWell(
                                onTap: () {
                                  log('${cast.id}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) => CastDetailsBloc(
                                          repositories,
                                          Seriesrepositories,
                                        )..add(FetchCastDetailsEvent(cast.id)),
                                        child: CastdetailsView(
                                          personName: cast.originalName,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        cast.profilePath != null
                                            ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                                            : '',
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        cast.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        '${cast.character}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: CustomText(
                          text: 'Crew',
                          fW: FontWeight.bold,
                          fS: 20,
                        ),
                      ),
                      const SizedBox(height: 10),

                      SizedBox(
                        height: 140,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.crew.length,
                          itemBuilder: (context, index) {
                            final crew = state.crew[index];
                            // final imageUrl = crew.profilePath != null;
                            final crewDepartment = crew.department;
                            log("${crewDepartment?.name}");
                            log(crew.name);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      crew.profilePath != null
                                          ? 'https://image.tmdb.org/t/p/w200${crew.profilePath}'
                                          : '',
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      crew.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      '${crewDepartment?.name.toLowerCase()}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
          Positioned(
            right: 20,
            top: 40,
            child: BlocConsumer<FavMovieBloc, FavMovieState>(
              listenWhen: (previous, current) =>
              current is Added || current is Removed || current is Failure,
              listener: (context, state) {
                state.when(initial: (){}, loading: (){}, loaded: (movie){
                }, added: (){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added To Favourites')));
                },removed: (){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed From Favourites')));
                },error: (error){
                  Text(error);
                });
              },
              builder: (context, state) {
                bool isFavorite = false;

                if (state is Loaded) {
                  isFavorite = state.movie.any(
                        (movie) => movie.id == widget.movieId,
                  );
                }
                
                return IconButton(
                  onPressed: () {
                    
                    final movie = Result(
                      id: widget.movieId,
                      title: widget.movieName,
                      posterPath: widget.posterPath,
                      voteAverage: widget.voteAverage,
                      overview: widget.movieDescritpion,
                    );

                    context.read<FavMovieBloc>().add(FavMovieEvent.addFavMovie(movie));
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 28,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),

          Positioned(
            right: 20,
            top: 80,
            child: BlocBuilder<WatchListBloc, WatchListState>(
              builder: (context, state) {
                final isBookmarked = state.movies.any(
                      (s) => s.id == widget.movieId,
                );

                return IconButton(
                  onPressed: () {
                    if (isBookmarked) {
                      context.read<WatchListBloc>().add(
                        WatchListEvent.removeMovieFromWatchList(widget.movieId),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed From WatchList')));
                    } else {
                      context.read<WatchListBloc>().add(
                        WatchListEvent.addMovieToWatchList(
                          Result(
                            id: widget.movieId,
                            overview: widget.movieDescritpion,
                            title: widget.movieName,posterPath: widget.posterPath,
                          ),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added To WatchList')));

                    }
                  },
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 15,
            top: 18,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}
