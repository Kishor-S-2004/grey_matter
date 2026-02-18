import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/model/common/searchCast_model.dart';
import 'package:grey_matter/model/movie/movie_review.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';

import '../../viewmodel/bloc/castDetails/cast_details_bloc.dart';
import '../../viewmodel/bloc/credits/credits_bloc.dart';
import '../../viewmodel/bloc/genre/genre_bloc.dart';
import '../../viewmodel/bloc/movieReview/movie_review_bloc.dart';
import '../../viewmodel/bloc/series_season/season_bloc.dart';
import '../screens/movieScreen/moviedetails.dart';
import '../screens/tvShowScreen/seasonscreen_view.dart';
import '../theme/appcolor.dart';

class ReviewContainer extends StatelessWidget {
  final int movieId;
  final List<MovieReviewResuts> results;

  const ReviewContainer({
    super.key,
    required this.movieId,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final reviewResults = results[index];

        final avatarPath = reviewResults.authorDetails.avatarPath ?? '';
        final avatarPfp = (avatarPath != null && avatarPath.isNotEmpty)
            ? 'https://image.tmdb.org/t/p/w500$avatarPath'
            : 'https://via.placeholder.com/150?text=No+Image';

        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(avatarPfp),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewResults.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        reviewResults.content,
                        style: const TextStyle(fontSize: 13),
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
        if(state is! GenreLoaded) return SizedBox();
          final allGenres = state.genres.genres;

        return SizedBox(
          height: 300,
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
                          Text('${genreNames.join(',')}',style: GoogleFonts.gabriela(fontSize: 8,fontWeight: FontWeight.w400,color: Colors.grey),)
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
