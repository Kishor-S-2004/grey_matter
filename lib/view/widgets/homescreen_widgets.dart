import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/model/movie/movieRec_model.dart';
import 'package:grey_matter/model/movie/toprated_model.dart';
import 'package:grey_matter/model/movie/upcoming_model.dart';
import 'package:grey_matter/view/screens/search_view.dart';
import 'package:grey_matter/view/theme/app_theme.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/viewmodel/bloc/genre/genre_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/upcomingmovies/upcomingmovies_bloc.dart';

import '../../model/movie/movie_model.dart';
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
  final List<Results> movies;

  const BasicCarousel({super.key, required this.movies});

  @override
  State<BasicCarousel> createState() => _BasicCarouselState();
}

class _BasicCarouselState extends State<BasicCarousel> {
  late final CarouselController _controller;
  Timer? _timer;
  int _currentIndex = 0;

  late final List<Results> filteredMovies;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();

    filteredMovies = widget.movies.where((movie) {
      final date = DateTime.tryParse(movie.releaseDate.toString());
      return date != null && date.year > 2025;
    }).toList();

    if (filteredMovies.isNotEmpty) {
      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        _currentIndex = (_currentIndex + 1) % filteredMovies.length;
        _controller.animateToItem(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (filteredMovies.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Text(
            'No upcoming movies',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: CarouselView(
        itemExtent: MediaQuery.of(context).size.width,
        controller: _controller,
        children: List.generate(filteredMovies.length, (index) {
          final movie = filteredMovies[index];

          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: GoogleFonts.gabriela(
                      color: Appcolor.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${movie.releaseDate.day}-${movie.releaseDate.month}-${movie.releaseDate.year}',
                    style: GoogleFonts.gabriela(
                      fontSize: 12,
                      color: Appcolor.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
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
  final List<Result> movies;

  const PopularMovieList({super.key, required this.movies});

  @override
  State<PopularMovieList> createState() => _PopularMovieListState();
}

class _PopularMovieListState extends State<PopularMovieList> {
  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    final movieRepository = MovieRepositories(MovieApiservice());

    if (widget.movies.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(child: Text('No movies found')),
      );
    }

    return SizedBox(
      height: 350,
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is! GenreLoaded) return const SizedBox();

          final allGenres = state.genres.genres;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];

              final genreNames = allGenres
                  .where((g) => movie.genreIds.contains(g.id))
                  .map((g) => g.name)
                  .toList();

              final imageUrl = (movie.posterPath.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://via.placeholder.com/500x750?text=No+Image';

              final isTapped = tappedIndex == index;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      tappedIndex = isTapped ? null : index;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) =>
                              CredtisBloc(movieRepository)
                                ..add(FetchCreditDetails(movie.id)),
                          child: Moviedetails(
                            movieId: movie.id,
                            movieName: movie.title,
                            movieGenre: genreNames.isNotEmpty
                                ? genreNames.first
                                : "Unknown",
                            movieDescritpion: movie.overview,
                            posterPath: imageUrl,
                            releaseDate: movie.releaseDate.year,
                            voteAverage: movie.voteAverage,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
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
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                isTapped ? movie.originalTitle : movie.title,
                                key: ValueKey(isTapped),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.gabriela(
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.primary,
                                  fontSize: 14,
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
      height: 320,
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
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      tappedIndex = isTapped ? null : index;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) => CredtisBloc(
                                  movieRepositories,
                                )..add(FetchCreditDetails(upcomingMovie.id)),
                                child: Moviedetails(
                                  movieId: upcomingMovie.id,
                                  movieName: upcomingMovie.title,
                                  movieGenre: genreNames.isNotEmpty
                                      ? genreNames.first
                                      : "Unknown",
                                  movieDescritpion: upcomingMovie.overview,
                                  posterPath: imageUrl,
                                  releaseDate: upcomingMovie.releaseDate.year,
                                  voteAverage: upcomingMovie.voteAverage,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 240,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            boxShadow: [
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
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Text(
                                isTapped
                                    ? upcomingMovie.originalTitle
                                    : upcomingMovie.title,
                                key: ValueKey(isTapped),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.gabriela(
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.primary,
                                  fontSize: 14,
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
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search a movie...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
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

            if (_showDropdown && results.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
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
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final movie = results[index];
                    final imageUrl = movie.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                        : '';

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
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  CredtisBloc(repositories)
                                    ..add(FetchCreditDetails(movie.id)),
                              child: Moviedetails(
                                movieId: movie.id,
                                movieName: movie.title!,
                                movieGenre: movie.title!,
                                movieDescritpion: movie.overview,
                                posterPath: imageUrl,
                                releaseDate: movie.releaseDate?.year,
                                voteAverage: movie.voteAverage,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
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
      height: 300,
      child: BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
        builder: (context, state) {
          if (state is MovieRecommendationLoading) {
            return const Center(child: CircularProgressIndicator());
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) =>
                                        CredtisBloc(repositories)..add(
                                          FetchCreditDetails(
                                            recommendationResult.id,
                                          ),
                                        ),
                                    child: Moviedetails(
                                      movieId: recommendationResult.id,
                                      movieName: recommendationResult.title,
                                      movieGenre: genreText,
                                      movieDescritpion:
                                          recommendationResult.overview,
                                      posterPath: imageUrl,
                                      releaseDate:
                                          recommendationResult
                                              .releaseDate
                                              ?.year ??
                                          0,
                                      voteAverage:
                                          recommendationResult.voteAverage,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 240,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color:Color(0xFFE7BC0F,),
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

                          const SizedBox(height: 8),

                          /// 🎬 Movie Title
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: GestureDetector(
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.gabriela(
                                    fontWeight: FontWeight.w600,
                                    color: Appcolor.primary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 4),

                          /// 🎭 Genre
                          Text(
                            genreText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.gabriela(
                              fontSize: 12,
                              color: Colors.grey,
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
