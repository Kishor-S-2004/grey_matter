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
import 'package:grey_matter/view/widgets/tvshowvideo_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/seriesCredits/series_credits_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../model/tvShow/tvShowVideo_model.dart';
import '../../../repositories/series_repositories.dart';
import '../../../viewmodel/bloc/castDetails/cast_details_bloc.dart';
import '../../../viewmodel/bloc/episodes/episodes_bloc.dart';
import '../../../viewmodel/bloc/series_season/season_bloc.dart';
import '../../../viewmodel/bloc/tvShowVideo/tv_show_video_bloc.dart';
import '../castDetails_view.dart';
import 'episode_view.dart';

// class TvShowPlayingScreen extends StatefulWidget {
//   final int seriesId;
//   final String seriesName;
//   final int seasonNumber;
//   final int episodeNumber;
//
//   const TvShowPlayingScreen({
//     super.key,
//     required this.seriesId,
//     required this.seriesName,
//     required this.seasonNumber,
//     required this.episodeNumber,
//   });
//
//   @override
//   State<TvShowPlayingScreen> createState() => _TvShowPlayingScreenState();
// }
//
// class _TvShowPlayingScreenState extends State<TvShowPlayingScreen> {
//   YoutubePlayerController? _controller;
//   String? _currentVideoKey;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<SeriesCreditsBloc>().add(
//       FetchSeriesCreditsEvent(
//         widget.seriesId,
//         widget.seasonNumber,
//         widget.episodeNumber,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller?.close();
//     super.dispose();
//   }
//
//   final SeriesRepositories repositories = SeriesRepositories(
//     SeriesApiService(),
//   );
//   final MovieRepositories Movierepositories = MovieRepositories(
//     MovieApiservice(),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Appcolor.background),
//       body: BlocBuilder<TvShowVideoBloc, TvShowVideoState>(
//         builder: (context, state) {
//           if (state is TvShowVideoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state is TvShowVideoLoaded) {
//             final youtubeVideos = state.results
//                 .where((e) => e.site == Site.YOU_TUBE)
//                 .toList();
//
//             if (youtubeVideos.isEmpty) {
//               return const Center(child: Text("No YouTube video available"));
//             }
//
//             final trailer = youtubeVideos.firstWhere(
//               (e) => e.type?.toLowerCase() == "trailer",
//               orElse: () => youtubeVideos.first,
//             );
//
//             final trailerKey = trailer.key;
//
//             if (trailerKey!.isEmpty) {
//               return const Center(child: Text("Invalid YouTube key"));
//             }
//
//             if (_currentVideoKey != trailerKey) {
//               _currentVideoKey = trailerKey;
//               _controller?.close();
//               _controller = YoutubePlayerController.fromVideoId(
//                 videoId: trailerKey,
//                 autoPlay: true,
//                 params: const YoutubePlayerParams(
//                   mute: false,
//                   origin: 'https://www.youtube-nocookie.com',
//                   showFullscreenButton: true,
//                   playsInline: true,
//                   showControls: true,
//                 ),
//               );
//             }
//
//             log('Playing YouTube key: $trailerKey');
//
//             return YoutubePlayerScaffold(
//               autoFullScreen: true,
//               enableFullScreenOnVerticalDrag: true,
//               fullscreenOrientations: const [
//                 DeviceOrientation.landscapeLeft,
//                 DeviceOrientation.landscapeRight,
//               ],
//               aspectRatio: 16 / 9,
//               controller: _controller!,
//               builder: (context, player) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // SizedBox(height: 30,),
//                       player,
//
//                       const SizedBox(height: 10),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: Text(
//                           '${widget.seriesName} - ${trailer.name}',
//                           style: GoogleFonts.gabriela(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: Text(
//                           trailer.publishedAt != null
//                               ? '${trailer.publishedAt!.day}-${trailer.publishedAt!.month}-${trailer.publishedAt!.year}'
//                               : '',
//                           style: GoogleFonts.gabriela(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       BlocBuilder<SeriesCreditsBloc, SeriesCreditsState>(
//                         builder: (context, creditState) {
//                           if (creditState is SeriesCreditsLoading) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           }
//
//                           if (creditState is SeriesCreditsLoaded) {
//                             return SizedBox(
//                               height: 140,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: creditState.seriesCastResult.length,
//                                 itemBuilder: (context, index) {
//                                   final cast =
//                                       creditState.seriesCastResult[index];
//
//                                   log('${cast.name} in seriesView');
//
//                                   final imageUrl = cast.profilePath != null
//                                       ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
//                                       : 'https://via.placeholder.com/150?text=No+Image';
//
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     BlocProvider(
//                                                       create: (context) =>
//                                                           CastDetailsBloc(
//                                                             Movierepositories,
//                                                             repositories,
//                                                           )..add(
//                                                             FetchCastDetailsEvent(
//                                                               cast.id,
//                                                             ),
//                                                           ),
//                                                       child: CastdetailsView(
//                                                         personName:
//                                                             cast.originalName,
//                                                       ),
//                                                     ),
//                                               ),
//                                             );
//                                           },
//                                           child: CircleAvatar(
//                                             radius: 40,
//                                             backgroundImage: NetworkImage(
//                                               imageUrl,
//                                             ),
//                                             onBackgroundImageError: (_, __) {},
//                                           ),
//                                         ),
//                                         const SizedBox(height: 6),
//                                         SizedBox(
//                                           width: 80,
//                                           child: Text(
//                                             cast.name,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 80,
//                                           child: Text(
//                                             cast.character ?? '',
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.center,
//                                             style: const TextStyle(
//                                               color: Colors.white70,
//                                               fontSize: 10,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               ),
//                             );
//                           }
//
//                           if (creditState is SeriesCreditsError) {
//                             return Center(child: Text(creditState.message));
//                           }
//
//                           return const SizedBox.shrink();
//                         },
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           'Recommended TvShow',
//                           style: GoogleFonts.gabriela(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 14),

//                       RecommendedSeriesList(seriesId: widget.seriesId),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//
//           if (state is TvShowVideoError) {
//             return Center(child: Text(state.errorMessage));
//           }
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }

class TvShowPlayingScreen extends StatefulWidget {
  final int seriesId;
  final int seasonNumber;
  final int episodeNumber;
  final String seriesName;
  final String? overview;
  final String episodeName;

  const TvShowPlayingScreen({
    super.key,
    required this.seriesId,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.seriesName,
    this.overview,
    required this.episodeName,
  });

  @override
  State<TvShowPlayingScreen> createState() => _TvShowPlayingScreenState();
}

class _TvShowPlayingScreenState extends State<TvShowPlayingScreen> {
  late final WebViewController controller;
  bool isLoading = true;

  late final String url =
      'https://vsembed.su/embed/tv?tmdb=${widget.seriesId}  &season=${widget.seasonNumber}&episode=${widget.episodeNumber}&sub_url=https%3A%2F%2Fvidsrc.me%2Fsample.srt&autoplay=1&autonext=1';

  @override
  void initState() {
    super.initState();
    context.read<EpisodesBloc>().add(
      FetchEpisodesEvent(widget.seriesId, widget.seasonNumber),
    );

    context.read<SeasonBloc>().add(FetchSeriesSeasons(widget.seriesId));

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 Chrome/120 Safari/537.36",
      )
      // ..setOnPageStarted()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (error) {
            debugPrint("Error: ${error.description}");
          },

          // 🚫 Block unwanted redirects (ads/popups)
          onNavigationRequest: (request) {
            if (!request.url.contains("vidsrc")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ✅ Load URL with headers (VERY IMPORTANT)
      ..loadRequest(
        Uri.parse(url),
        headers: {
          "Referer": "https://vsembed.su/",
          "Origin": "https://vsembed.su",
        },
      );
  }

  // 🔙 Handle back navigation inside WebView
  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    }
    return true;
  }

  bool isTapped = false;
  bool isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    final SeriesRepositories repositories = SeriesRepositories(
      SeriesApiService(),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: isFullScreen ? null : AppBar(title: Text(widget.seriesName)),
        body: Stack(
          children: [
           isFullScreen ? SizedBox.expand(child: WebViewWidget(controller: controller),) :  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: WebViewWidget(controller: controller),
                ),

                BlocBuilder<EpisodesBloc, EpisodesState>(
                  builder: (context, state) {
                    if (state is! EpisodesLoaded) return SizedBox();
                    final episodeName = state.episodes.first.name;
                    final episodeOverView = state.episodes.first.overview;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                widget.episodeNumber != 1
                                    ? widget.episodeName
                                    : episodeName,
                                style: GoogleFonts.gabriela(
                                  color: Appcolor.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isTapped = !isTapped;
                                });
                              },
                              icon: isTapped
                                  ? Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      color: Appcolor.primary,
                                    )
                                  : Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Appcolor.primary,
                                    ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                          child: Text(
                            maxLines: isTapped ? 10 : 1,
                            overflow: TextOverflow.ellipsis,
                            widget.episodeNumber != 1
                                ? widget.overview!
                                : episodeOverView,
                            style: GoogleFonts.gabriela(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(
                  height: 30,
                  child: BlocBuilder<SeasonBloc, SeasonState>(
                    builder: (context, state) {
                      if (state is! SeasonLoaded) return SizedBox();
                      final seasonList = state.seasons;
                      return SeasonList(
                        seasonList: seasonList,
                        seriesId: widget.seriesId,
                        seriesName: widget.seriesName,
                        seasonNumber: widget.seasonNumber,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<EpisodesBloc, EpisodesState>(
                    builder: (context, state) {
                      if (state is EpisodesLoading) {
                        return SizedBox();
                      }

                      if (state is EpisodesLoaded) {
                        return EpisodeList(
                          episodes: state.episodes,
                          seriesId: widget.seriesId,
                          seriesName: widget.seriesName,
                        );
                      }

                      if (state is EpisodesError) {
                        return const Center(
                          child: Text('Error fetching episodes'),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),

            IconButton(onPressed: () {
              setState(() {
                isFullScreen = !isFullScreen;
                if(!isFullScreen) {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                  ]);

                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.edgeToEdge,
                  );
                }else{
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);

                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.immersiveSticky,
                  );
                }
              });
            }, icon: isFullScreen ? Icon(Icons.fullscreen_exit) : Icon(Icons.fullscreen)),

            if (isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
