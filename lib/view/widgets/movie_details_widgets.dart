import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/model/common/searchCast_model.dart';
import 'package:grey_matter/model/movie/movie_review.dart';
import 'package:grey_matter/repositories/favMovie_repositories.dart';
import 'package:grey_matter/repositories/movieReview_repo.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/reviews/movieReviews/moviereviews_event.dart';
import 'package:grey_matter/viewmodel/bloc/users/userDetails/userdetails_bloc.dart';

import '../../viewmodel/bloc/castDetails/cast_details_bloc.dart';
import '../../viewmodel/bloc/credits/credits_bloc.dart';
import '../../viewmodel/bloc/favMovie/fav_movie_bloc.dart';
import '../../viewmodel/bloc/genre/genre_bloc.dart';
import '../../viewmodel/bloc/movieReview/movie_review_bloc.dart';
import '../../viewmodel/bloc/reviews/movieReviews/moviereviews_bloc.dart';
import '../../viewmodel/bloc/reviews/movieReviews/moviereviews_state.dart';
import '../../viewmodel/bloc/series_season/season_bloc.dart';
import '../../viewmodel/bloc/users/userDetails/userdetails_state.dart' hide Loading;
import '../screens/movieScreen/moviedetails.dart';
import '../screens/tvShowScreen/seasonscreen_view.dart';
import '../theme/appcolor.dart';

class ReviewContainer extends StatelessWidget {
  final int movieId;

  const ReviewContainer({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieReviewBloc, MovieReviewState>(
      builder: (context, state) {
        if (state is MovieReviewLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is MovieReviewLoaded) {
          final results = state.reviewResult;

          if (results.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("No reviews available"),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final reviewResults = results[index];

              final avatarPath = reviewResults.authorDetails?.avatarPath ?? '';

              final avatarPfp = avatarPath.isNotEmpty
                  ? 'https://image.tmdb.org/t/p/w500$avatarPath'
                  : 'https://via.placeholder.com/150?text=No+Image';

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(avatarPfp),
                      onBackgroundImageError: (_, __) {},
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewResults.author ?? "Unknown",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            reviewResults.content ?? "",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        if (state is MovieReviewError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              state.errorMsg,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class CastDetails extends StatelessWidget {
  const CastDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastDetailsBloc, CastDetailsState>(
      builder: (context, state) {
        if (state is CastDetailsLoading) {
          return SizedBox(child: Center(child: CircularProgressIndicator()));
        }
        if (state is CastDetailsLoaded) {
          final castDetails = state.castDetails;
          final imageUrl = castDetails.profilePath.isNotEmpty
              ? 'https://image.tmdb.org/t/p/w200${castDetails.profilePath}'
              : '';
          log('${castDetails.name}');
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(imageUrl, height: 150, width: 100),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${castDetails.name}',
                        fW: FontWeight.bold,
                        fS: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Text(
                          '${castDetails.knownForDepartment}',
                          style: GoogleFonts.gabriela(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Text(
                          '${castDetails.placeOfBirth}',
                          style: GoogleFonts.gabriela(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                '${castDetails.biography}',
                style: GoogleFonts.gabriela(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20),
            ],
          );
        }
        if (state is CastDetailsError) {
          return Text('${state.errorMessage}');
        }
        return SizedBox();
      },
    );
  }
}

class CastMovie extends StatefulWidget {
  final List<KnownFor> knownFor;

  const CastMovie({super.key, required this.knownFor});

  @override
  State<CastMovie> createState() => _CastMovieState();
}

class _CastMovieState extends State<CastMovie> {
  int? tappedIndex;

  @override
  Widget build(BuildContext context) {
    final MovieRepositories movieRepositories = MovieRepositories(
      MovieApiservice(),
    );
    final SeriesRepositories seriesRepositories = SeriesRepositories(
      SeriesApiService(),
    );
    if (widget.knownFor.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(child: Text("No movies found")),
      );
    }

    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is! GenreLoaded) return SizedBox();
        final allGenres = state.genres.genres;

        return SizedBox(
          height: 340,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.knownFor.length,
            itemBuilder: (context, index) {
              final kW = widget.knownFor[index];

              final genreNames = allGenres
                  .where((g) => kW.genreIds.contains(g.id))
                  .map((g) => g.name)
                  .toList();

              log('${kW.releaseDate} ${kW.overview}');
              final imageUrl =
                  (kW.posterPath != null && kW.posterPath!.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/w500${kW.posterPath}'
                  : 'https://via.placeholder.com/500x750?text=No+Image';

              final isTapped = tappedIndex == index;

              final displayTitle = kW.title ?? kW.name ?? "Unknown title";
              final originalTitle =
                  kW.originalTitle ?? kW.originalName ?? 'Unknown Title';

              log('${kW.title}');

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (kW.name!.isEmpty) {
                          log('${kW.title} and name is null');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) =>
                                    CredtisBloc(movieRepositories)
                                      ..add(FetchCreditDetails(kW.id!)),
                                child: BlocProvider(
                                  create: (context) => FavMovieBloc(
                                    repository: FavMovieRepository(),
                                  ),
                                  child: Moviedetails(
                                    movieId: kW.id!,
                                    movieName: kW.title!,
                                    movieGenre: genreNames.first,
                                    movieDescritpion: kW.overview!,
                                    posterPath: imageUrl,
                                    releaseDate: kW.releaseDate!.year,
                                    voteAverage: kW.voteAverage!,
                                  ),
                                ),
                              ),
                            ),
                          );
                          return;
                        } else {
                          log('${kW.name} and title is null');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    SeasonBloc(seriesRepositories)
                                      ..add(FetchSeriesSeasons(kW.id!)),
                                child: SeasonscreenView(
                                  seriesId: kW.id!,
                                  seriesName: kW.name!,
                                ),
                              ),
                            ),
                          );
                          return;
                        }
                      },
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Color(0xFFE7BC0F), blurRadius: 8),
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                tappedIndex = isTapped ? null : index;
                              });
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 250),
                              child: Text(
                                isTapped ? displayTitle : originalTitle,
                                key: ValueKey(isTapped),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.gabriela(
                                  fontWeight: FontWeight.w600,
                                  color: Appcolor.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${genreNames.join(',')}',
                            style: GoogleFonts.gabriela(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
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
          ),
        );
      },
    );
  }
}

class ReviewTextField extends StatelessWidget {
  final TextEditingController controller;
  ReviewTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Add a review',
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Appcolor.primary)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class ReviewButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onPressed;

  const ReviewButton({super.key, required this.btnText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * .2,
          decoration: BoxDecoration(
            color: Appcolor.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              btnText,
              style: GoogleFonts.gabriela(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewFirebaseContainer extends StatelessWidget {
  final int movieId;
  const ReviewFirebaseContainer({super.key,required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MoviereviewsBloc(MovieReviewRepo())
            ..add(MovieReviewsEvent.fetchReview(movieId)),
      child: BlocBuilder<MoviereviewsBloc, MovieReviewsState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is Loaded) {
            return ListView.builder(
              itemCount: state.results.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reviewResults = state.results[index];

                final avatarPath =
                    reviewResults.authorDetails?.avatarPath ?? '';

                final avatarPfp = avatarPath.isNotEmpty
                    ? 'https://image.tmdb.org/t/p/w500$avatarPath'
                    : 'https://via.placeholder.com/150?text=No+Image';

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(avatarPfp),
                        onBackgroundImageError: (_, __) {},
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reviewResults.author ?? "Unknown",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              reviewResults.content ?? "",
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          if (state is Failure) {
            return Text(state.error);
          }
          return Container();
        },
      ),
    );
  }
}
