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
import 'package:grey_matter/viewmodel/bloc/movieReview/movie_review_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/reviews/movieReviews/moviereviews_event.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:grey_matter/viewmodel/bloc/movieVideo/movie_video_bloc.dart';

import '../../../viewmodel/bloc/movieRecommendations/movie_recommendation_bloc.dart';
import '../../../viewmodel/bloc/reviews/movieReviews/moviereviews_bloc.dart';
import '../../../viewmodel/bloc/reviews/movieReviews/moviereviews_state.dart';

class MoviePlayingScreen extends StatefulWidget {
  final int movieId;
  final String moviename;

  const MoviePlayingScreen({
    super.key,
    required this.movieId,
    required this.moviename,
  });

  @override
  State<MoviePlayingScreen> createState() => _MoviePlayingScreenState();
}

class _MoviePlayingScreenState extends State<MoviePlayingScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // context.read<MovieVideoBloc>().add(FetchMovieUrl(widget.movieId));
    context.read<MovieReviewBloc>().add(FetchMovieReview(widget.movieId));
    context.read<MovieRecommendationBloc>().add(
      FetchMovieRecommendations(widget.movieId),
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  final TextEditingController _reviewController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Appcolor.background),
      body: BlocBuilder<MovieVideoBloc, MovieVideoState>(
        builder: (context, state) {
          if (state is MovieVideoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieVideoLoaded) {
            final youtubeVideos = state.result
                .where((e) => e.site == "YouTube")
                .toList();

            if (youtubeVideos.isEmpty) {
              return const Center(child: Text("No YouTube trailer available"));
            }

            final trailer = youtubeVideos.firstWhere(
              (e) => e.type == "Trailer",
              orElse: () => youtubeVideos.first,
            );

            // log('${trailer.key} this is the key');
            final trailerKey = trailer.key;

            _controller ??= YoutubePlayerController.fromVideoId(
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

            return YoutubePlayerScaffold(
              autoFullScreen: true,
              enableFullScreenOnVerticalDrag: true,
              fullscreenOrientations: [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
              aspectRatio: 16 / 9,
              builder: (context, player) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      player,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8,
                        ),
                        child: Text(
                          '${widget.moviename} ${'(${trailer.publishedAt!.year})'} ${trailer.name}',
                          style: GoogleFonts.gabriela(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '${trailer.publishedAt!.day} - ${trailer.publishedAt!.month} - ${trailer.publishedAt!.year}',
                          style: GoogleFonts.gabriela(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Recommended Movies',
                          style: GoogleFonts.gabriela(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),

                      RecommendationMovieList(movieId: widget.movieId),
                      SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Reviews',
                          style: GoogleFonts.gabriela(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                          BlocConsumer<MoviereviewsBloc, MovieReviewsState>(
                            listener: (context, state) {
                              state.when(
                                initial: () {},
                                loading: () {},
                                added: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Review Added Successfully')),
                                  );
                                  _reviewController.clear();
                                },
                                loaded: (_) {},
                                failure: (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Failed to add review')),
                                  );
                                },
                              );
                            },
                            builder: (context, state) {
                              final isLoading = state is Loading;

                              return SizedBox(
                                height: 50,
                                child: ReviewButton(
                                  btnText: isLoading ? "Posting..." : "Post",
                                  onPressed: isLoading
                                      ? null
                                      : () async{
                                    final reviewText = _reviewController.text.trim();

                                    if (reviewText.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Write something')),
                                      );
                                      return;
                                    }

                                    final uid = FirebaseAuth.instance.currentUser?.uid;
                                    final userData =await FirebaseFirestore.instance.collection('Users').doc(uid).get();

                                    final author = userData['Username'];
                                    context.read<MoviereviewsBloc>().add(
                                      MovieReviewsEvent.addReview(
                                        MovieReviewResults(
                                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                                          movieId: widget.movieId,
                                          movieName: widget.moviename,
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
                          )
                        ],
                      ),
                      ReviewFirebaseContainer(movieId: widget.movieId,),
                      ReviewContainer(movieId: widget.movieId),
                    ],
                  ),
                );
              },
              controller: _controller!,
            );
          }

          if (state is MovieVideoError) {
            return Center(child: Text(state.errorMsg));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
