import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/tv_show_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/seriesCredits/series_credits_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../model/tvShow/tvShowVideo_model.dart';
import '../../../repositories/series_repositories.dart';
import '../../../viewmodel/bloc/castDetails/cast_details_bloc.dart';
import '../../../viewmodel/bloc/tvShowVideo/tv_show_video_bloc.dart';
import '../castDetails_view.dart';

class TvShowPlayingScreen extends StatefulWidget {
  final int seriesId;
  final String seriesName;
  final int seasonNumber;
  final int episodeNumber;

  const TvShowPlayingScreen({
    super.key,
    required this.seriesId,
    required this.seriesName,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  @override
  State<TvShowPlayingScreen> createState() => _TvShowPlayingScreenState();
}

class _TvShowPlayingScreenState extends State<TvShowPlayingScreen> {
  YoutubePlayerController? _controller;
  String? _currentVideoKey;

  @override
  void initState() {
    super.initState();
    context.read<SeriesCreditsBloc>().add(
      FetchSeriesCreditsEvent(
        widget.seriesId,
        widget.seasonNumber,
        widget.episodeNumber,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  final SeriesRepositories repositories = SeriesRepositories(
    SeriesApiService(),
  );
  final MovieRepositories Movierepositories = MovieRepositories(
    MovieApiservice(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.background ,
      ),
      body: BlocBuilder<TvShowVideoBloc, TvShowVideoState>(
        builder: (context, state) {
          if (state is TvShowVideoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TvShowVideoLoaded) {

            final youtubeVideos = state.results
                .where((e) => e.site == Site.YOU_TUBE)
                .toList();

            if (youtubeVideos.isEmpty) {
              return const Center(child: Text("No YouTube video available"));
            }

            final trailer = youtubeVideos.firstWhere(
              (e) => e.type?.toLowerCase() == "trailer",
              orElse: () => youtubeVideos.first,
            );

            final trailerKey = trailer.key;

            if (trailerKey!.isEmpty) {
              return const Center(child: Text("Invalid YouTube key"));
            }

            if (_currentVideoKey != trailerKey) {
              _currentVideoKey = trailerKey;
              _controller?.close();
              _controller = YoutubePlayerController.fromVideoId(
                videoId: trailerKey,
                autoPlay: true,
                params: const YoutubePlayerParams(
                  mute: false,
                  origin: 'https://www.youtube-nocookie.com',
                  showFullscreenButton: true,
                  playsInline: true,
                  showControls: true,
                ),
              );
            }

            log('Playing YouTube key: $trailerKey');

            return YoutubePlayerScaffold(
              autoFullScreen: true,
              enableFullScreenOnVerticalDrag: true,
              fullscreenOrientations: const [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              aspectRatio: 16 / 9,
              controller: _controller!,
              builder: (context, player) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // SizedBox(height: 30,),
                      player,

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '${widget.seriesName} - ${trailer.name}',
                          style: GoogleFonts.gabriela(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          trailer.publishedAt != null
                              ? '${trailer.publishedAt!.day}-${trailer.publishedAt!.month}-${trailer.publishedAt!.year}'
                              : '',
                          style: GoogleFonts.gabriela(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<SeriesCreditsBloc, SeriesCreditsState>(
                        builder: (context, creditState) {
                          if (creditState is SeriesCreditsLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (creditState is SeriesCreditsLoaded) {
                            return SizedBox(
                              height: 140,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: creditState.seriesCastResult.length,
                                itemBuilder: (context, index) {
                                  final cast =
                                      creditState.seriesCastResult[index];

                                  log('${cast.name} in seriesView');

                                  final imageUrl = cast.profilePath != null
                                      ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                                      : 'https://via.placeholder.com/150?text=No+Image';

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (context) =>
                                                          CastDetailsBloc(
                                                            Movierepositories,
                                                            repositories,
                                                          )..add(
                                                            FetchCastDetailsEvent(
                                                              cast.id,
                                                            ),
                                                          ),
                                                      child: CastdetailsView(
                                                        personName:
                                                            cast.originalName,
                                                      ),
                                                    ),
                                              ),
                                            );
                                          },
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(imageUrl,),
                                            onBackgroundImageError: (_, __) {},
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
                                            cast.character ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10,
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

                          if (creditState is SeriesCreditsError) {
                            return Center(child: Text(creditState.message));
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Recommended TvShow',
                          style: GoogleFonts.gabriela(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),


                      RecommendedSeriesList(seriesId: widget.seriesId,)
                    ],
                  ),
                );
              },
            );
          }

          if (state is TvShowVideoError) {
            return Center(child: Text(state.errorMessage));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
