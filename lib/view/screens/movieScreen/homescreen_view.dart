import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/movie/movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/topratedmovie/topratedmovies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/upcomingmovies/upcomingmovies_bloc.dart';

// import '../../viewmodel/bloc/movie/movie_state.dart';

class HomescreenView extends StatelessWidget {
  const HomescreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Appcolor.background,
          leadingWidth: 45,
          leading: Transform.translate(
            offset: const Offset(13, 0),
            child: CircleAvatar(child: Icon(Icons.person), radius: 5),
          ),
          scrolledUnderElevation: 1,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: 'Hello, Smith',
                  fW: FontWeight.bold,
                  fS: 20,
                ),
              ),
              SizedBox(height: 5),
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Appcolor.background,
                ),
                child: Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          ],
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieLoaded) {
              return SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14,),
                    CustomSearchBar(),
                    SizedBox(height: 17,),
                    BlocBuilder<UpcomingmoviesBloc, UpcomingmoviesState>(
                      builder: (context, state) {
                        if(state is UpcomingMoviesLoading){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        if(state is UpcomingmoviesLoaded){
                          return BasicCarousel(movies: state.upcomingModel);
                        }  if(state is UpcomingmoviesError){
                          return Center(child: Text(state.errorMsg),);
                        }
                        return SizedBox();
                      },
                    ),
                    SizedBox(height: 20,),
                    // GenreList(),
                    SizedBox(height: 17,),
                    CustomText(
                        text: 'Top Rated', fW: FontWeight.bold, fS: 20),
                    SizedBox(height: 17,),
                    BlocBuilder<TopratedmoviesBloc, TopratedmoviesState>(
                      builder: (context, topRatedMovieState) {
                        if (topRatedMovieState is TopratedmoviesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (topRatedMovieState is TopratedmoviesLoaded) {
                          return TopRatedMovieList(
                            movie: topRatedMovieState.movies,
                          );
                        }

                        if (topRatedMovieState is TopratedmoviesError) {
                          return Center(child: Text(topRatedMovieState.errorMsg));
                        }

                        return const Text('Error');
                      },
                    ),
                    CustomText(
                        text: 'Most Popular', fW: FontWeight.bold, fS: 20),
                    SizedBox(height: 17,),
                    PopularMovieList(movies: state.movies),
                  ],
                ),
              );
            }

            if (state is MovieError) {
              log('${state.errormsg}');
              return Center(child: Text(state.errormsg));
            }

            return const SizedBox();
          },
        )

    );
  }
}
