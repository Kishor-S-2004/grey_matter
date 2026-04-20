import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/viewmodel/bloc/movieVideo/movie_video_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../model/tvShow/season_model.dart';
import '../../viewmodel/bloc/episodes/episodes_bloc.dart';
import '../screens/tvShowScreen/episode_view.dart';
import '../theme/appcolor.dart';
import 'homescreen_widgets.dart';

class SeasonList extends StatefulWidget {
  final List<SeasonElement> seasonList;
  final int seriesId;
  final String seriesName;
  final int? seasonNumber;
  const SeasonList({
    super.key,
    required this.seasonList,
    required this.seriesId,
    required this.seriesName,
    this.seasonNumber,
  });

  @override
  State<SeasonList> createState() => _SeasonListState();
}

class _SeasonListState extends State<SeasonList> {
  late int selectedSeason;

  @override
  void initState() {
    super.initState();
    selectedSeason =
        widget.seasonNumber ?? widget.seasonList.first.seasonNumber!;
  }

  @override
  Widget build(BuildContext context) {
    final filteredSeasons = widget.seasonList
        .where((season) => season.seasonNumber != 0)
        .toList();

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredSeasons.length,
        itemBuilder: (context, index) {
          final seasons = filteredSeasons[index];
          final season = seasons.seasonNumber!;

          final bool isSelected = season == selectedSeason;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSeason = season;
                });

                context.read<EpisodesBloc>().add(
                  FetchEpisodesEvent(widget.seriesId, season),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: Appcolor.primary),
                  color: isSelected ? Appcolor.primary : Appcolor.background,
                ),
                child: Center(
                  child: Text(
                    'Season $season',
                    style: GoogleFonts.gabriela(
                      color: isSelected
                          ? Appcolor.background
                          : Appcolor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FromYoutubeVideo extends StatefulWidget {
  const FromYoutubeVideo({super.key});

  @override
  State<FromYoutubeVideo> createState() => _FromYoutubeVideoState();
}

class _FromYoutubeVideoState extends State<FromYoutubeVideo> {
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieVideoBloc, MovieVideoState>(
      builder: (context, state) {
        if (state is MovieVideoLoading) {
          return AspectRatio(aspectRatio: 16/9,child: const Center(child: CircularProgressIndicator()));
        }

        if (state is MovieVideoLoaded) {
          final youtubeVideo = state.result
              .where((e) => e.site.toLowerCase() == 'youtube')
              .toList();

          if (youtubeVideo.isEmpty) {
            return const Center(child: Text('No Youtube Video Available'));
          }

          final trailer = youtubeVideo.firstWhere(
                (e) => e.type == 'Trailer',
            orElse: () => youtubeVideo.first,
          );

          final trailerKey = trailer.key;

          if (_controller == null ||
              _controller!.metadata.videoId != trailerKey) {
            _controller?.close();
            _controller = YoutubePlayerController.fromVideoId(
              videoId: trailerKey,
              autoPlay: true,
              params: const YoutubePlayerParams(
                mute: true,
                showFullscreenButton: true,
                origin: 'https://www.youtube-nocookie.com',
                playsInline: true,
                showControls: true,
              ),
            );
          }

          return YoutubePlayerScaffold(
            enableFullScreenOnVerticalDrag: true,
            aspectRatio: 16 / 9,
            fullscreenOrientations: const [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ],
            builder: (context, player) {
              return player;
            },
            controller: _controller!,
          );
        }

        if (state is MovieVideoError) {
          return AspectRatio(aspectRatio:16/9,child: Center(child: Text(state.errorMsg)));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
