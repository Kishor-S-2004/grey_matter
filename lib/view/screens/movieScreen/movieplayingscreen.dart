import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/model/movie/movie_review.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/view/widgets/movie_details_widgets.dart';
import 'package:grey_matter/view/widgets/tvshowvideo_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/movieReview/movie_review_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/reviews/movieReviews/moviereviews_event.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:grey_matter/viewmodel/bloc/movieVideo/movie_video_bloc.dart';

import '../../../viewmodel/bloc/movieRecommendations/movie_recommendation_bloc.dart';
import '../../../viewmodel/bloc/reviews/movieReviews/moviereviews_bloc.dart';
import '../../../viewmodel/bloc/reviews/movieReviews/moviereviews_state.dart';
//
// class MoviePlayingScreen extends StatefulWidget {
//   final int movieId;
//   final String moviename;
//
//   const MoviePlayingScreen({
//     super.key,
//     required this.movieId,
//     required this.moviename,
//   });
//
//   @override
//   State<MoviePlayingScreen> createState() => _MoviePlayingScreenState();
// }
//
// class _MoviePlayingScreenState extends State<MoviePlayingScreen> {
//   YoutubePlayerController? _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     // context.read<MovieVideoBloc>().add(FetchMovieUrl(widget.movieId));
//     context.read<MovieReviewBloc>().add(FetchMovieReview(widget.movieId));
//     context.read<MovieRecommendationBloc>().add(
//       FetchMovieRecommendations(widget.movieId),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller?.close();
//     super.dispose();
//   }
//
//   final TextEditingController _reviewController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Appcolor.background),
//       body: BlocBuilder<MovieVideoBloc, MovieVideoState>(
//         builder: (context, state) {
//           if (state is MovieVideoLoading) {
//             return const Center(child: CircularProgressIndicator(color: Appcolor.primary,));
//           }
//
//           if (state is MovieVideoLoaded) {
//             final youtubeVideos = state.result
//                 .where((e) => e.site == "YouTube")
//                 .toList();
//
//             if (youtubeVideos.isEmpty) {
//               return const Center(child: Text("No YouTube trailer available"));
//             }
//
//             final trailer = youtubeVideos.firstWhere(
//               (e) => e.type == "Trailer",
//               orElse: () => youtubeVideos.first,
//             );
//
//             // log('${trailer.key} this is the key');
//             final trailerKey = trailer.key;
//
//             _controller ??= YoutubePlayerController.fromVideoId(
//               videoId: trailerKey,
//               autoPlay: true,
//               params: const YoutubePlayerParams(
//                 mute: true,
//                 showFullscreenButton: true,
//                 origin: 'https://www.youtube-nocookie.com',
//                 playsInline: true,
//                 showControls: true,
//               ),
//             );
//
//             return YoutubePlayerScaffold(
//               autoFullScreen: true,
//               enableFullScreenOnVerticalDrag: true,
//               fullscreenOrientations: [
//                 DeviceOrientation.landscapeLeft,
//                 DeviceOrientation.landscapeRight,
//               ],
//               aspectRatio: 16 / 9,
//               builder: (context, player) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       player,
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0,
//                           vertical: 8,
//                         ),
//                         child: Text(
//                           '${widget.moviename} ${'(${trailer.publishedAt!.year})'} ${trailer.name}',
//                           style: GoogleFonts.gabriela(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           '${trailer.publishedAt!.day} - ${trailer.publishedAt!.month} - ${trailer.publishedAt!.year}',
//                           style: GoogleFonts.gabriela(
//                             fontSize: 15,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 18),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           'Recommended Movies',
//                           style: GoogleFonts.gabriela(
//                             fontSize: 20,
//                             color: Appcolor.primary,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 14),
//
//                       RecommendationMovieList(movieId: widget.movieId),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           'Reviews',
//                           style: GoogleFonts.gabriela(
//                             fontSize: 20,
//                             color: Appcolor.primary,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ReviewTextField(
//                               controller: _reviewController,
//                             ),
//                           ),
//                           BlocConsumer<MoviereviewsBloc, MovieReviewsState>(
//                             listener: (context, state) {
//                               state.when(
//                                 initial: () {},
//                                 loading: () {},
//                                 removed: (){
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('Review Removed Successfully')),
//                                   );
//                                 },
//                                 added: () {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('Review Added Successfully')),
//                                   );
//                                   _reviewController.clear();
//                                 },
//                                 loaded: (_) {},
//                                 failure: (error) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(content: Text('Failed to add review')),
//                                   );
//                                 },
//                               );
//                             },
//                             builder: (context, state) {
//                               final isLoading = state is Loading;
//
//                               return SizedBox(
//                                 height: 50,
//                                 child: ReviewButton(
//                                   btnText: isLoading ? "Posting..." : "Post",
//                                   onPressed: isLoading
//                                       ? null
//                                       : () async{
//                                     final reviewText = _reviewController.text.trim();
//
//                                     if (reviewText.isEmpty) {
//                                       ScaffoldMessenger.of(context).showSnackBar(
//                                         const SnackBar(content: Text('Write something')),
//                                       );
//                                       return;
//                                     }
//
//                                     final uid = FirebaseAuth.instance.currentUser?.uid;
//                                     final userData =await FirebaseFirestore.instance.collection('Users').doc(uid).get();
//
//                                     final author = userData['Username'];
//                                     context.read<MoviereviewsBloc>().add(
//                                       MovieReviewsEvent.addReview(
//                                         MovieReviewResults(
//                                           id: DateTime.now().millisecondsSinceEpoch.toString(),
//                                           movieId: widget.movieId,
//                                           movieName: widget.moviename,
//                                           content: reviewText,
//                                           author: author,
//                                           authorDetails: null,
//                                           createdAt: null,
//                                           updatedAt: null,
//                                           url: null,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           )
//                         ],
//                       ),
//                       ReviewFirebaseContainer(movieId: widget.movieId,),
//                       ReviewContainer(movieId: widget.movieId),
//                     ],
//                   ),
//                 );
//               },
//               controller: _controller!,
//             );
//           }
//
//           if (state is MovieVideoError) {
//             return Center(child: Text(state.errorMsg));
//           }
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoviePlayingScreen extends StatefulWidget {
  final int movieId;
  final String movieName;
  const MoviePlayingScreen({
    super.key,
    required this.movieId,
    required this.movieName,
  });

  @override
  State<MoviePlayingScreen> createState() => _MoviePlayingScreenState();
}

class _MoviePlayingScreenState extends State<MoviePlayingScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  final TextEditingController _reviewController = TextEditingController();
  bool isTapped = false;
  bool videoPresent = true;
  // YoutubePlayerController? _controller;

  late final String url =
      "https://vsembed.su/embed/movie?tmdb=${widget.movieId}&sub_url=https://vidsrc.me/sample.srt&autoplay=1";

  @override
  void initState() {
    super.initState();

    context.read<MovieRecommendationBloc>().add(
      FetchMovieRecommendations(widget.movieId),
    );

    context.read<MovieReviewBloc>().add(FetchMovieReview(widget.movieId));

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        "Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 Chrome/120 Safari/537.36",
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
          },
          onWebResourceError: (error) {
            setState(() => videoPresent = false);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: isTapped
            ? null
            : AppBar(
                title: Text(widget.movieName, style: GoogleFonts.gabriela()),
              ),
        body: Stack(
                children: [
                  isTapped
                      ? SizedBox.expand(
                          child: videoPresent ? WebViewWidget(controller: controller) : FromYoutubeVideo(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             videoPresent ? AspectRatio(
                                aspectRatio: 16 / 9,
                                child: WebViewWidget(controller: controller),
                              ) : FromYoutubeVideo(),

                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  'Recommended Movies',
                                  style: GoogleFonts.gabriela(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 14),

                              RecommendationMovieList(movieId: widget.movieId),

                              SizedBox(height: 7),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  'Reviews',
                                  style: GoogleFonts.gabriela(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),

                              Row(
                                children: [
                                  Expanded(
                                    child: ReviewTextField(
                                      controller: _reviewController,
                                    ),
                                  ),
                                  BlocConsumer<
                                    MoviereviewsBloc,
                                    MovieReviewsState
                                  >(
                                    listener: (context, state) {
                                      state.when(
                                        removed: () {},
                                        initial: () {},
                                        loading: () {},
                                        added: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Review Added Successfully',
                                              ),
                                            ),
                                          );
                                          _reviewController.clear();
                                        },
                                        loaded: (_) {},
                                        failure: (error) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Failed to add review',
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    builder: (context, state) {
                                      final isLoading = state is Loading;

                                      return SizedBox(
                                        height: 50,
                                        child: ReviewButton(
                                          btnText: isLoading
                                              ? "Posting..."
                                              : "Post",
                                          onPressed: isLoading
                                              ? null
                                              : () async {
                                                  final reviewText =
                                                      _reviewController.text
                                                          .trim();

                                                  if (reviewText.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'Write something',
                                                        ),
                                                      ),
                                                    );
                                                    return;
                                                  }

                                                  final uid = FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      ?.uid;
                                                  final userData =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(uid)
                                                          .get();

                                                  final author =
                                                      userData['Username'];
                                                  context.read<MoviereviewsBloc>().add(
                                                    MovieReviewsEvent.addReview(
                                                      MovieReviewResults(
                                                        id: DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString(),
                                                        movieId: widget.movieId,
                                                        movieName:
                                                            widget.movieName,
                                                        content: reviewText,
                                                        author: author,
                                                        authorDetails: null,
                                                        createdAt: null,
                                                        updatedAt: null,
                                                        url: null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              ReviewFirebaseContainer(movieId: widget.movieId),
                              ReviewContainer(movieId: widget.movieId),
                            ],
                          ),
                        ),

                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isTapped = !isTapped;
                          if (!isTapped) {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                            ]);

                            SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.edgeToEdge,
                            );
                          } else {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight,
                            ]);

                            SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersiveSticky,
                            );
                          }
                        });
                      },
                      icon: isTapped
                          ? Icon(Icons.close_fullscreen_sharp)
                          : Icon(Icons.open_in_full),
                    ),
                  ),
                  if (isLoading) SizedBox(),
                ],
              ),
      ),
    );
  }
}
