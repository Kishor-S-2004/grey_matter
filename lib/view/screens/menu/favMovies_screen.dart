import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/theme/appcolor.dart';

import '../../../viewmodel/bloc/favMovie/fav_movie_bloc.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_event.dart';
import '../../../viewmodel/bloc/favMovie/fav_movie_state.dart';

class FavMoviesScreen extends StatefulWidget {
  const FavMoviesScreen({super.key});

  @override
  State<FavMoviesScreen> createState() => _FavMoviesScreenState();
}

class _FavMoviesScreenState extends State<FavMoviesScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<FavMovieBloc>().add(FetchFavMovies());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.background,
        title: const Text('Favourite Movies'),
      ),
      body: BlocProvider(
        create: (context) => FavMovieBloc()..add(FavMovieEvent.fetchFavMovies()),
        child: BlocBuilder<FavMovieBloc, FavMovieState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is Loaded) {
              if (state.movie.isEmpty) {
                return const Center(
                  child: Text(
                    "No favourites yet",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return GridView.builder(
                itemCount: state.movie.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final favMovie = state.movie[index];

                  final imageUrl = (favMovie.posterPath != null &&
                      favMovie.posterPath!.isNotEmpty)
                      ? 'https://image.tmdb.org/t/p/w500${favMovie.posterPath}'
                      : 'https://via.placeholder.com/500x750?text=No+Image';

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            }

            if (state is Failure) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
