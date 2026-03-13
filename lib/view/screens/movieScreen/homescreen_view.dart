import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  // late Animation<double> animation;
  // late AnimationController controller;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   controller =
  //       AnimationController(duration: const Duration(seconds: 2), vsync: DrawerControllerState());
  //   animation = Tween<double>(begin: 0, end: 300).animate(controller)
  //     ..addListener(() {
  //       setState(() {
  //         // The state that has changed here is the animation object's value.
  //       });
  //     });
  //   controller.forward();
  // }

  @override
  Widget build(BuildContext context) {
    final String _uid = FirebaseAuth.instance.currentUser!.uid;
    return BlocProvider(
      create: (context) =>
      UserdetailsBloc()..add(UserdetailsEvent.userDetails(_uid)),
      child: Scaffold(
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
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator(
                color: Appcolor.primary,
                padding: EdgeInsets.symmetric(vertical: 130),
              ),);
            }

            if (state is MovieLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14),
                    CustomSearchBar(),
                    SizedBox(height: 17),
                    BlocBuilder<UpcomingmoviesBloc, UpcomingmoviesState>(
                      builder: (context, state) {
                        if (state is UpcomingMoviesLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Appcolor.primary,
                              padding: EdgeInsets.symmetric(vertical: 150),
                            ),
                          );
                        }
                        if (state is UpcomingmoviesLoaded) {
                          return BasicCarousel(movies: state.upcomingModel);
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
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Appcolor.primary,
                              padding: EdgeInsets.symmetric(vertical: 130),
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
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Appcolor.primary,
                              padding: EdgeInsets.symmetric(vertical: 130),
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
                    PopularMovieList(movies: state.movies),
                  ],
                ),
              );
            }

            if (state is MovieError) {
              log('${state.errormsg} in popular movie');
              return Center(child: Text(state.errormsg));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
