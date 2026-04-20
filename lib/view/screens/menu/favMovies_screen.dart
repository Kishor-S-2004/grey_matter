import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/repositories/favMovie_repositories.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/view/screens/movieScreen/moviedetails.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/viewmodel/bloc/credits/credits_bloc.dart';

import '../../../viewmodel/bloc/favMovie/fav_movie_bloc.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_event.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_state.dart';
import '../../../viewmodel/bloc/genre/genre_bloc.dart';

class FavMoviesScreen extends StatefulWidget {
  const FavMoviesScreen({super.key});

  @override
  State<FavMoviesScreen> createState() => _FavMoviesScreenState();
}

class _FavMoviesScreenState extends State<FavMoviesScreen> {
  final movieRepository = MovieRepositories(MovieApiservice());

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavMovieBloc>().add(FavMovieEvent.fetchFavMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Appcolor.primary),
        backgroundColor: Appcolor.background,
        title: Text(
          'Favourite Movies',
          style: GoogleFonts.gabriela(
            color: Appcolor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<FavMovieBloc, FavMovieState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is Loaded) {
            if (state.movie.isEmpty) {
              return const Center(
                child: Text(
                  "No favourites yet",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            return BlocBuilder<GenreBloc, GenreState>(
              builder: (context, genreState) {
                if (genreState is! GenreLoaded) return SizedBox();

                final allGenres = genreState.genres.genres;
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.movie.length,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),

                  itemBuilder: (context, index) {
                    final favMovie = state.movie[index];

                    final imageUrl =
                        (favMovie.posterPath != null &&
                            favMovie.posterPath!.isNotEmpty)
                        ? 'https://image.tmdb.org/t/p/w500${favMovie.posterPath}'
                        : 'https://via.placeholder.com/500x750?text=No+Image';

                    return Stack(
                      children: [

                        Card(
                          elevation: 3,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

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
                                        reverseTransitionDuration: const Duration(
                                          milliseconds: 600,
                                        ),
                                        pageBuilder:
                                            (context, animation, secondaryAnimation) =>
                                            BlocProvider(
                                              create: (context) => CredtisBloc(
                                                movieRepository,
                                              )..add(FetchCreditDetails(favMovie.id ?? 0)),
                                              child: BlocProvider(
                                                create: (context) => FavMovieBloc(
                                                  repository: FavMovieRepository(),
                                                ),
                                                child: Moviedetails(
                                                  heroTag: 'movie_${favMovie!.id}',
                                                  movieId: favMovie.id ?? 0,
                                                  movieName: favMovie.title ?? "Unknown",
                                                  movieGenre: favMovie.genreName ?? "",
                                                  movieDescritpion:
                                                  favMovie.overview ?? "No overview",
                                                  posterPath: imageUrl,
                                                  releaseDate:
                                                  favMovie.releaseYear ?? 0,
                                                  voteAverage: favMovie.voteAverage ?? 0.0,
                                                ),
                                              ),
                                            ),

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
                                    tag: 'movie_${favMovie.id}',
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  favMovie.title ?? "No Title",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.gabriela(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Appcolor.primary,
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
                              context.read<FavMovieBloc>().add(
                                FavMovieEvent.removeFavMovie(favMovie.id!),
                              );
                            },
                            icon: Icon(Icons.favorite, color: Colors.red,size: 30,),
                          ),
                        ),

                      ],
                    );
                  },
                );
              },
            );
          }

          if (state is Failure) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
