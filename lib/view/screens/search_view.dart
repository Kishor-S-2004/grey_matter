import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/view/widgets/searchscreen_widgets.dart';
// import 'package:grey_matter/viewmodel/bloc/movie/movie_state.dart';

import '../../viewmodel/bloc/movie/movie_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if(state is MovieLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is MovieLoaded){
          return SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17,),
                // CustomSearchBar(),
                SizedBox(height: 17,),
                GenreList(),
                SizedBox(height: 17,),
                CustomText(text: 'Today', fW: FontWeight.bold, fS: 20),
                SizedBox(height: 17,),

                ShowDetailContainer(),
                SizedBox(height: 17,),

                CustomText(
                    text: 'Recommended for you', fW: FontWeight.bold, fS: 20),
                SizedBox(height: 17,),

                PopularMovieList(movies: state.movies,)

              ],
            ),
          );}
          return Text('Error');
        },
      ),
    );
  }
}
