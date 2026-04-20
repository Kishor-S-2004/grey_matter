import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/movie/movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/nowPlayingMovies/now_playing_movies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/topratedmovie/topratedmovies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/upcomingmovies/upcomingmovies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/users/userDetails/userdetails_event.dart';

import '../../../viewmodel/bloc/users/userDetails/userdetails_bloc.dart';
import '../../../viewmodel/bloc/users/userDetails/userdetails_state.dart';

// import '../../viewmodel/bloc/movie/movie_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    context.read<UserdetailsBloc>().add(
      UserdetailsEvent.userDetails(uid),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final String _uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.background,
        leadingWidth: 45,
        leading: Transform.translate(
          offset: const Offset(13, 0),
          child: CircleAvatar(child: Icon(Icons.person), radius: 5),
        ),
        scrolledUnderElevation: 1,
        title: BlocBuilder<UserdetailsBloc, UserdetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const SizedBox(),
              loaded: (userData) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(
                      text: userData.Username!,
                      fW: FontWeight.bold,
                      fS: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomText(
                      text: "Let's stream your favourite movie",
                      fW: FontWeight.w300,
                      fS: 14,
                    ),
                  ),
                ],
              ),
              error: (error) => Text('$error'),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14),
            CustomSearchBar(),
            SizedBox(height: 17),
            BlocBuilder<UpcomingmoviesBloc, UpcomingmoviesState>(
              builder: (context, state) {
                if (state is UpcomingMoviesLoading) {
                  return SizedBox(height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return SkeletonItem(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  borderRadius: BorderRadius.circular(14),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height / 3,
                                ),
                              ),


                              // Expanded(
                              //   child: SkeletonParagraph(
                              //     style: SkeletonParagraphStyle(
                              //       lines: 2,
                              //       spacing: 6,
                              //       lineStyle: SkeletonLineStyle(
                              //         randomLength: true,
                              //         height: 10,
                              //         borderRadius: BorderRadius.circular(8),
                              //         minLength: MediaQuery.of(context).size.width / 6,
                              //         maxLength: MediaQuery.of(context).size.width / 3,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                if (state is UpcomingmoviesLoaded) {
                  return NewCarousel(movies: state.upcomingModel);
                }
                if (state is UpcomingmoviesError) {
                  return Center(
                    child: Text('${state.errorMsg} in upcming movies'),
                  );
                }
                return SizedBox();
              },
            ),
            // GenreList(),
            SizedBox(height: 17),
            CustomText(
              text: 'Now Playing',
              fW: FontWeight.bold,
              fS: 20,
            ),
            SizedBox(height: 17),
            BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
              builder: (context, nowPlayingMovieState) {
                if (nowPlayingMovieState is NowPlayingMoviesLoading) {
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

                if (nowPlayingMovieState is NowPlayingMoviesLoaded) {
                  return NowPlayingMovieList(
                    movies: nowPlayingMovieState.nowPlayingMovieResult,
                  );
                }

                if (nowPlayingMovieState is NowPlayingMoviesError) {
                  return Center(
                    child: Text(
                      '${nowPlayingMovieState.errorMessage} in now Playing',
                    ),
                  );
                }

                return const Text('Error');
              },
            ),
            CustomText(text: 'Top Rated', fW: FontWeight.bold, fS: 20),
            SizedBox(height: 17),
            BlocBuilder<TopratedmoviesBloc, TopratedmoviesState>(
              builder: (context, topRatedMovieState) {
                if (topRatedMovieState is TopratedmoviesLoading) {
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

                if (topRatedMovieState is TopratedmoviesLoaded) {
                  return TopRatedMovieList(
                    movie: topRatedMovieState.movies,
                  );
                }

                if (topRatedMovieState is TopratedmoviesError) {
                  return Center(
                    child: Text(
                      '${topRatedMovieState.errorMsg} in top Rated',
                    ),
                  );
                }

                return const Text('Error');
              },
            ),
            CustomText(
              text: 'Most Popular',
              fW: FontWeight.bold,
              fS: 20,
            ),
            SizedBox(height: 17),
            BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
              if(state is MovieLoading){
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
              if(state is MovieLoaded){
                return PopularMovieList(movies: state.movies);
              }
              if(state is MovieError){
                return Text("${state.errormsg}");
              }
              return SizedBox();
            },)
          ],
        ),
      ),
    );
  }
}
