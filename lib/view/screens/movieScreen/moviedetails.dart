import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/screens/castDetails_view.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/view/widgets/movie_details_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/credits/credits_bloc.dart';

import '../../../api_service/tv_show_apiservice.dart';
import '../../../viewmodel/bloc/castDetails/cast_details_bloc.dart';
import '../../../viewmodel/bloc/movieVideo/movie_video_bloc.dart';
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
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<CredtisBloc>().add(
  //     FetchCreditDetails(widget.movieId),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final MovieRepositories repositories = MovieRepositories(MovieApiservice());
    final SeriesRepositories Seriesrepositories = SeriesRepositories(SeriesApiService());
    // CredtisBloc credtisBloc = CredtisBloc(repositories.getCreditDetails(widget.movieId) as MovieRepositories);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: 15),
          SizedBox(
            height: screenHeight * 0.7,
            width: double.infinity,
            child: Opacity(
              opacity: 0.12,
              child: Image.network(widget.posterPath, fit: BoxFit.cover),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),

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
                                        create: (context) => CastDetailsBloc(repositories,Seriesrepositories)..add(FetchCastDetailsEvent(cast.id)),
                                        child: CastdetailsView(personName: cast.originalName,),
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
