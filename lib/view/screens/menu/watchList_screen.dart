import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/repositories/seriesWatchList_repository.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_event.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_state.dart';

import '../../theme/appcolor.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  @override
  void initState(){
    super.initState();
    context.read<WatchListBloc>()..add(WatchListEvent.fetchSeriesFromWatchList())..add(WatchListEvent.fetchMovieFromWatchList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.background,
        title: const Text('WatchList'),
      ),
      body: BlocBuilder<WatchListBloc, WatchListState>(
        builder: (context, state) {

         if(state.isLoading){
           return Center(child: CircularProgressIndicator(),);
         }
          if (state.movies.isEmpty && state.series.isEmpty) {
            return const Center(
              child: Text(
                "No WatchList yet",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// MOVIES SECTION
                if (state.movies.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.movies.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final favMovie = state.movies[index];

                      final imageUrl =
                      (favMovie.posterPath != null &&
                          favMovie.posterPath!.isNotEmpty)
                          ? 'https://image.tmdb.org/t/p/w500${favMovie.posterPath}'
                          : 'https://via.placeholder.com/500x750?text=No+Image';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  favMovie.title ?? "Unknown Title",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Appcolor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],

                /// SERIES SECTION
                if (state.series.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Series",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.series.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final favSeries = state.series[index];

                      final imageUrl =
                      (favSeries.posterPath != null &&
                          favSeries.posterPath!.isNotEmpty)
                          ? 'https://image.tmdb.org/t/p/w500${favSeries.posterPath}'
                          : 'https://via.placeholder.com/500x750?text=No+Image';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${favSeries.name} ${favSeries.overview}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Appcolor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );();
  }
}
