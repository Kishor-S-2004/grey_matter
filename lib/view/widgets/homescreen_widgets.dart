import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/model/movie/movieRec_model.dart';
import 'package:grey_matter/model/movie/toprated_model.dart';
import 'package:grey_matter/model/movie/upcoming_model.dart';
import 'package:grey_matter/repositories/favMovie_repositories.dart';
import 'package:grey_matter/view/screens/search_view.dart';
import 'package:grey_matter/view/theme/app_theme.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/viewmodel/bloc/favMovie/fav_movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/favMovie/fav_movie_event.dart';
import 'package:grey_matter/viewmodel/bloc/genre/genre_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/upcomingmovies/upcomingmovies_bloc.dart';

import '../../model/movie/movie_model.dart';
import '../../model/movie/nowPlayingMovies_model.dart';
import '../../model/movie/searchmovie_model.dart';
import '../../repositories/movie_repositories.dart';
import '../../viewmodel/bloc/credits/credits_bloc.dart';
import '../../viewmodel/bloc/movieRecommendations/movie_recommendation_bloc.dart';
import '../../viewmodel/bloc/searchedMovie/searched_movie_bloc.dart';
import '../screens/movieScreen/moviedetails.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fW;
  final double fS;
  Color? color;
  CustomText({
    super.key,
    required this.text,
    required this.fW,
    required this.fS,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14),
      child: Text(
        text,
        style: GoogleFonts.gabriela(
          fontSize: fS,
          fontWeight: fW,
          color: Appcolor.primary,
        ),
      ),
    );
  }
}

class BasicCarousel extends StatefulWidget {
  final List<Results>? movies;

  const BasicCarousel({super.key, required this.movies});

  @override
  State<BasicCarousel> createState() => _BasicCarouselState();
}

class _BasicCarouselState extends State<BasicCarousel> {
  late final List<Results> filteredMovies;

  final MovieRepositories movieRepositories = MovieRepositories(
    MovieApiservice(),
  );

  @override
  void initState() {
    super.initState();

    filteredMovies =
        widget.movies?.where((movie) {
          final date = movie.releaseDate;
          return date != null && date.year > 2025;
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    if (filteredMovies.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(
          child: Text(
            'No upcoming movies',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is! GenreLoaded) {
          return const SizedBox();
        }

        final allGenre = state.genres.genres;

        return SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              viewportFraction: 0.85,
            ),
            items: filteredMovies.map((movie) {
              final imageUrl =
                  (movie.posterPath != null && movie.posterPath!.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://via.placeholder.com/500x750';

              final genreNames = allGenre
                  .where((g) => movie.genreIds?.contains(g.id) ?? false)
                  .map((genre) => genre.name)
                  .toList();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 900),
                      reverseTransitionDuration: const Duration(
                        milliseconds: 600,
                      ),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BlocProvider(
                            create: (context) =>
                                CredtisBloc(movieRepositories)
                                  ..add(FetchCreditDetails(movie.id ?? 0)),
                            child: BlocProvider(
                              create: (context) => FavMovieBloc(
                                repository: FavMovieRepository(),
                              ),
                              child: Moviedetails(
                                heroTag: 'movie_${movie.id}',
                                movieId: movie.id ?? 0,
                                movieName: movie.title ?? "Unknown",
                                movieGenre: genreNames.isNotEmpty
                                    ? genreNames.first
                                    : "Unknown",
                                movieDescritpion:
                                    movie.overview ?? "No overview",
                                posterPath: imageUrl,
                                releaseDate: movie.releaseDate?.year ?? 0,
                                voteAverage: movie.voteAverage ?? 0.0,
                              ),
                            ),
                          ),

                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Hero(
                      tag: 'movie_${movie.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 28,
                      left: 10,
                      child: Text(
                        movie.title ?? "Unknown",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.gabriela(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        '${movie.releaseDate?.day ?? ''} - ${movie.releaseDate?.month ?? ''} - ${movie.releaseDate?.year ?? ''}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.gabriela(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class GenreList extends StatefulWidget {
  const GenreList({super.key});

  @override
  State<GenreList> createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> {
  int selectedIndex = 0;
  late int id;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GenreLoaded) {
          return SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.genres.genres.length,
              itemBuilder: (context, index) {
                // final genre = genres[index];
                final genreNames = state.genres.genres;
                final genreName = genreNames[index];
                final genreId = genreName.id;
                final bool isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        log('$genreId');
                      });
                      log('clicked $index');
                    },
                    child: Container(
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: isSelected
                            ? Appcolor.background
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: CustomText(
                          text: genreName.name,
                          fW: FontWeight.w400,
                          fS: 15,
                          color: isSelected ? Color(0xFF12CDD9) : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        if (state is GenreError) {
          return Center(child: Text('${state.errormsg}'));
        }
        return SizedBox(height: 10);
      },
    );
  }
}

class PopularMovieList extends StatefulWidget {
  final List<Result>? movies;

  const PopularMovieList({super.key, required this.movies});

  @override
  State<PopularMovieList> createState() => _PopularMovieListState();
}

class _PopularMovieListState extends State<PopularMovieList> {
  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepositories(MovieApiservice());

    if (widget.movies!.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('No movies found')),
      );
    }

    return SizedBox(
      height: 300,
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is! GenreLoaded) return const SizedBox();

          final allGenres = state.genres.genres;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies?.length,
            itemBuilder: (context, index) {
              final movie = widget.movies?[index];

              final genreNames = allGenres
                  .where((g) => movie!.genreIds!.contains(g.id))
                  .map((g) => g.name)
                  .toList();

              final imageUrl = (movie!.posterPath!.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://via.placeholder.com/500x750?text=No+Image';

              final isTapped = tappedIndex == index;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 900),
                        reverseTransitionDuration: const Duration(
                          milliseconds: 600,
                        ),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BlocProvider(
                              create: (context) =>
                                  CredtisBloc(movieRepository)
                                    ..add(FetchCreditDetails(movie.id ?? 0)),
                              child: BlocProvider(
                                create: (context) => FavMovieBloc(
                                  repository: FavMovieRepository(),
                                ),
                                child: Moviedetails(
                                  heroTag: 'movie_${movie.id}',
                                  movieId: movie.id ?? 0,
                                  movieName: movie.title ?? "Unknown",
                                  movieGenre: genreNames.isNotEmpty
                                      ? genreNames.first
                                      : "Unknown",
                                  movieDescritpion:
                                      movie.overview ?? "No overview",
                                  posterPath: imageUrl,
                                  releaseDate: movie.releaseDate?.year ?? 0,
                                  voteAverage: movie.voteAverage ?? 0.0,
                                ),
                              ),
                            ),

                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'movie_${movie.id}',
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width * 0.33,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7BC0F),
                                blurRadius: 8,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  tappedIndex = isTapped ? null : index;
                                });
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child: Text(
                                  isTapped
                                      ? movie.originalTitle!
                                      : movie.title!,
                                  key: ValueKey(isTapped),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.gabriela(
                                    fontWeight: FontWeight.w600,
                                    color: Appcolor.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              genreNames.isNotEmpty
                                  ? genreNames.join(',')
                                  : "Unknown",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.gabriela(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TopRatedMovieList extends StatefulWidget {
  final List<TopRatedMovieResult> movie;

  const TopRatedMovieList({super.key, required this.movie});

  @override
  State<TopRatedMovieList> createState() => _TopRatedMovieListState();
}

class _TopRatedMovieListState extends State<TopRatedMovieList> {
  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    final movieRepositories = MovieRepositories(MovieApiservice());

    if (widget.movie.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('No movies found')),
      );
    }

    return SizedBox(
      height: 300,
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is! GenreLoaded) {
            return const SizedBox();
          }

          final allGenres = state.genres.genres;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movie.length,
            itemBuilder: (context, index) {
              final upcomingMovie = widget.movie[index];

              final genreNames = allGenres
                  .where((g) => upcomingMovie.genreIds.contains(g.id))
                  .map((g) => g.name)
                  .toList();

              final imageUrl = (upcomingMovie.posterPath.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/w500${upcomingMovie.posterPath}'
                  : 'https://via.placeholder.com/500x750?text=No+Image';

              final isTapped = tappedIndex == index;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                ) => BlocProvider(
                                  create: (context) => CredtisBloc(
                                    movieRepositories,
                                  )..add(FetchCreditDetails(upcomingMovie.id)),
                                  child: BlocProvider(
                                    create: (context) => FavMovieBloc(
                                      repository: FavMovieRepository(),
                                    ),
                                    child: Moviedetails(
                                      heroTag: 'movie_${upcomingMovie.id}',
                                      movieId: upcomingMovie.id,
                                      movieName: upcomingMovie.title,
                                      movieGenre: genreNames.isNotEmpty
                                          ? genreNames.first
                                          : "Unknown",
                                      movieDescritpion: upcomingMovie.overview,
                                      posterPath: imageUrl,
                                      releaseDate:
                                          upcomingMovie.releaseDate.year,
                                      voteAverage: upcomingMovie.voteAverage,
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
                        tag: 'movie_${upcomingMovie.id}',
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width * 0.33,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE7BC0F),
                                blurRadius: 8,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tappedIndex = isTapped ? null : index;
                              });
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                isTapped
                                    ? upcomingMovie.originalTitle
                                    : upcomingMovie.title,
                                key: ValueKey(isTapped),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.gabriela(
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            genreNames.isNotEmpty
                                ? genreNames.join(',')
                                : "Unknown",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.gabriela(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showDropdown = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final MovieRepositories repositories = MovieRepositories(MovieApiservice());
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchedMovieBloc, SearchedMovieState>(
      builder: (context, state) {
        List<SearchMovieResult> results = [];

        if (state is SearchedMovieLoaded) {
          results = state.searchedResult;
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search a movie...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolor.primary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _showDropdown = true;
                    context.read<SearchedMovieBloc>().add(
                      FetchSearchedMovieEvent(value),
                    );
                    setState(() {});
                  } else {
                    _showDropdown = false;
                    setState(() {});
                  }
                },
              ),
            ),

            if (_showDropdown && results.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Appcolor.background,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(maxHeight: 300),
                child: BlocBuilder<GenreBloc, GenreState>(
                  builder: (context, genreState) {
                    if (genreState is! GenreLoaded) {
                      return SizedBox();
                    }

                    final allGenres = genreState.genres.genres;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final movie = results[index];
                        final imageUrl = movie.posterPath != null
                            ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                            : '';

                        final genre = allGenres
                            .where((g) => movie.genreIds.contains(g.id))
                            .map((g) => g.name)
                            .toList();

                        return GestureDetector(
                          onTap: () {
                            // Handle selection: hide dropdown & log movie info
                            _showDropdown = false;
                            _controller.text = movie.title!;
                            setState(() {});
                            log(
                              'Selected: ${movie.title}, Poster: ${movie.posterPath}',
                            );
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
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                    ) => BlocProvider(
                                      create: (context) => CredtisBloc(
                                        repositories,
                                      )..add(FetchCreditDetails(movie.id ?? 0)),
                                      child: BlocProvider(
                                        create: (context) => FavMovieBloc(
                                          repository: FavMovieRepository(),
                                        ),
                                        child: Moviedetails(
                                          heroTag: 'movie_${movie.id}',
                                          movieId: movie.id ?? 0,
                                          movieName: movie.title ?? "Unknown",
                                          movieGenre: genre.isNotEmpty
                                              ? genre.first
                                              : "Unknown",
                                          movieDescritpion:
                                              movie.overview ?? "No overview",
                                          posterPath: imageUrl,
                                          releaseDate:
                                              movie.releaseDate?.year ?? 0,
                                          voteAverage: movie.voteAverage ?? 0.0,
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                            ),
                            child: Hero(
                              tag: 'movie_${movie.id}',
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                margin: const EdgeInsets.symmetric(vertical: 2),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Appcolor.primary,
                                      blurRadius: 2,
                                      blurStyle: BlurStyle.outer,
                                    ),
                                  ],
                                  color: Appcolor.background,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    if (imageUrl.isNotEmpty)
                                      Image.network(
                                        imageUrl,
                                        height: 50,
                                        width: 35,
                                        fit: BoxFit.cover,
                                      ),
                                    const SizedBox(width: 10),
                                    if (imageUrl.isNotEmpty)
                                      Expanded(
                                        child: Text(
                                          movie.title!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class RecommendationMovieList extends StatefulWidget {
  final int movieId;

  const RecommendationMovieList({super.key, required this.movieId});

  @override
  State<RecommendationMovieList> createState() =>
      _RecommendationMovieListState();
}

class _RecommendationMovieListState extends State<RecommendationMovieList> {
  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    final MovieRepositories repositories = MovieRepositories(MovieApiservice());

    return SizedBox(
      height: 330,
      child: BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
        builder: (context, state) {
          if (state is MovieRecommendationLoading) {
            return SizedBox(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SkeletonItem(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            borderRadius: BorderRadius.circular(10),
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 240,
                          ),
                        ),

                        const SizedBox(height: 8),

                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 2,
                            spacing: 6,
                            lineStyle: SkeletonLineStyle(
                              randomLength: true,
                              height: 10,
                              borderRadius: BorderRadius.circular(8),
                              minLength: MediaQuery.of(context).size.width / 6,
                              maxLength: MediaQuery.of(context).size.width / 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          if (state is MovieRecommendationLoaded) {
            final movies = state.results;

            if (movies.isEmpty) {
              return const Center(child: Text('No recommendations found'));
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final recommendationResult = movies[index];

                final imageUrl = recommendationResult.posterPath.isNotEmpty
                    ? 'https://image.tmdb.org/t/p/w500${recommendationResult.posterPath}'
                    : 'https://via.placeholder.com/500x750?text=No+Image';

                final isTapped = tappedIndex == index;

                return BlocBuilder<GenreBloc, GenreState>(
                  builder: (context, genreState) {
                    if (genreState is! GenreLoaded) {
                      return const SizedBox();
                    }

                    final allGenres = genreState.genres.genres;

                    final genreNames = allGenres
                        .where(
                          (g) => recommendationResult.genreIds.contains(g.id),
                        )
                        .map((g) => g.name)
                        .toList();

                    final genreText = genreNames.isNotEmpty
                        ? genreNames.join(', ')
                        : 'Unknown';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    milliseconds: 900,
                                  ),
                                  reverseTransitionDuration: const Duration(
                                    milliseconds: 600,
                                  ),
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => BlocProvider(
                                        create: (context) =>
                                            CredtisBloc(repositories)..add(
                                              FetchCreditDetails(
                                                recommendationResult.id ?? 0,
                                              ),
                                            ),
                                        child: BlocProvider(
                                          create: (context) => FavMovieBloc(
                                            repository: FavMovieRepository(),
                                          ),
                                          child: Moviedetails(
                                            heroTag:
                                                'movie_${recommendationResult.id}',
                                            movieId:
                                                recommendationResult.id ?? 0,
                                            movieName:
                                                recommendationResult.title ??
                                                "Unknown",
                                            movieGenre: genreNames.isNotEmpty
                                                ? genreNames.first
                                                : "Unknown",
                                            movieDescritpion:
                                                recommendationResult.overview ??
                                                "No overview",
                                            posterPath: imageUrl,
                                            releaseDate:
                                                recommendationResult
                                                    .releaseDate
                                                    ?.year ??
                                                0,
                                            voteAverage:
                                                recommendationResult
                                                    .voteAverage ??
                                                0.0,
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
                              tag: 'movie_${recommendationResult.id}',
                              child: Container(
                                height: 240,
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFE7BC0F),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tappedIndex = isTapped ? null : index;
                                    });
                                  },
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    child: Text(
                                      isTapped
                                          ? recommendationResult.originalTitle
                                          : recommendationResult.title,
                                      key: ValueKey(isTapped),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.gabriela(
                                        fontWeight: FontWeight.w600,
                                        color: Appcolor.primary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  genreText,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.gabriela(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }

          if (state is MovieRecommendationError) {
            return Center(child: Text(state.errorMsg));
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class NowPlayingMovieList extends StatefulWidget {
  final List<NowPlayingMovieResult>? movies;

  const NowPlayingMovieList({super.key, required this.movies});

  @override
  State<NowPlayingMovieList> createState() => _NowPlayingMovieListState();
}

class _NowPlayingMovieListState extends State<NowPlayingMovieList> {
  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    final movieRepositories = MovieRepositories(MovieApiservice());

    if (widget.movies!.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('No movies found')),
      );
    }

    return SizedBox(
      height: 300,
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is! GenreLoaded) {
            return const SizedBox();
          }

          final allGenres = state.genres.genres;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies?.length,
            itemBuilder: (context, index) {
              final movie = widget.movies?[index];

              final genreNames = allGenres
                  .where((g) => movie?.genreIds?.contains(g.id) ?? false)
                  .map((g) => g.name)
                  .toList();

              final imageUrl =
                  (movie?.posterPath != null && movie!.posterPath!.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://via.placeholder.com/500x750?text=No+Image';

              final isTapped = tappedIndex == index;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                                        movieRepositories,
                                      )..add(FetchCreditDetails(movie.id ?? 0)),
                                      child: BlocProvider(
                                        create: (context) => FavMovieBloc(
                                          repository: FavMovieRepository(),
                                        ),
                                        child: Moviedetails(
                                          heroTag: 'movie_${movie!.id}',
                                          movieId: movie.id ?? 0,
                                          movieName: movie.title ?? "Unknown",
                                          movieGenre: genreNames.isNotEmpty
                                              ? genreNames.first
                                              : "Unknown",
                                          movieDescritpion:
                                              movie.overview ?? "No overview",
                                          posterPath: imageUrl,
                                          releaseDate:
                                              movie.releaseDate?.year ?? 0,
                                          voteAverage: movie.voteAverage ?? 0.0,
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
                        tag: 'movie_${movie?.id}',
                        child: Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width * 0.33,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFFE7BC0F),
                                blurRadius: 8,
                                blurStyle: BlurStyle.outer,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 🎬 Title + Genre
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tappedIndex = isTapped ? null : index;
                              });
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: Text(
                                isTapped
                                    ? movie?.originalTitle ?? "Unknown"
                                    : movie?.title ?? "Unknown",
                                key: ValueKey(isTapped),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.gabriela(
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            genreNames.isNotEmpty
                                ? genreNames.join(', ')
                                : "Unknown",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.gabriela(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NewCarousel extends StatefulWidget {
  final List<Results>? movies;

  const NewCarousel({super.key, required this.movies});

  @override
  State<NewCarousel> createState() => _NewCarouselState();
}

class _NewCarouselState extends State<NewCarousel> {
  late final List<Results> filteredMovies;

  final MovieRepositories movieRepositories = MovieRepositories(
    MovieApiservice(),
  );

  @override
  void initState() {
    super.initState();

    filteredMovies =
        widget.movies?.where((movie) {
          final date = movie.releaseDate;
          return date != null && date.year > 2025;
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    if (filteredMovies.isEmpty) {
      return const SizedBox(
        height: 250,
        child: Center(
          child: Text(
            'No upcoming movies',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is! GenreLoaded) {
          return const SizedBox();
        }

        final allGenre = state.genres.genres;

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              animateToClosest: true,
              viewportFraction: 0.80,
            ),
            items: filteredMovies.map((movie) {
              final imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

              final errorIcon = Icon(Icons.image_not_supported,size: 30,);

              final genreNames = allGenre
                  .where((g) => movie.genreIds?.contains(g.id) ?? false)
                  .map((genre) => genre.name)
                  .toList();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 900),
                      reverseTransitionDuration: const Duration(
                        milliseconds: 600,
                      ),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          BlocProvider(
                            create: (context) =>
                                CredtisBloc(movieRepositories)
                                  ..add(FetchCreditDetails(movie.id ?? 0)),
                            child: BlocProvider(
                              create: (context) => FavMovieBloc(
                                repository: FavMovieRepository(),
                              ),
                              child: Moviedetails(
                                heroTag: 'movie_${movie.id}',
                                movieId: movie.id ?? 0,
                                movieName: movie.title ?? "Unknown",
                                movieGenre: genreNames.isNotEmpty
                                    ? genreNames.first
                                    : "Unknown",
                                movieDescritpion:
                                    movie.overview ?? "No overview",
                                posterPath: imageUrl,
                                releaseDate: movie.releaseDate?.year ?? 0,
                                voteAverage: movie.voteAverage ?? 0.0,
                              ),
                            ),
                          ),

                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: movie.posterPath != null ? ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: Image.network(imageUrl, fit: BoxFit.fill),
                      ) : Center(child: errorIcon),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
