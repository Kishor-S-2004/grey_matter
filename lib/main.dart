import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/screens/movieScreen/homescreen_view.dart';
import 'package:grey_matter/view/theme/app_theme.dart';
import 'package:grey_matter/view/widgets/bottomnavi.dart';
import 'package:grey_matter/viewmodel/bloc/airing_today/airingtoday_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/bottomnavigation/bottom_navigation_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/credits/credits_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/genre/genre_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/movie/movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/movieRecommendations/movie_recommendation_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/movieReview/movie_review_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/searchCast/search_cast_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/searchedMovie/searched_movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/searchedTvShow/searched_tv_show_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/seriesCredits/series_credits_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/top_rated_tvshow/top_rated_tv_show_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/topratedmovie/topratedmovies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/tvShowVideo/tv_show_video_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/upcomingmovies/upcomingmovies_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // load env
  runApp(const GreyMatter());
}

class GreyMatter extends StatefulWidget {
  const GreyMatter({super.key});

  @override
  State<GreyMatter> createState() => _GreyMatterState();
}

class _GreyMatterState extends State<GreyMatter> {
  final movieApiServices = MovieApiservice();
  final seriesApiServices = SeriesApiService();
  late final MovieRepositories movieRepositories = MovieRepositories(movieApiServices);
  late final SeriesRepositories seriesRepository = SeriesRepositories(seriesApiServices);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavigationBloc()),
        BlocProvider(
          create: (context) => MovieBloc(movieRepositories)..add(FetchMovieDetails()),
        ),
        BlocProvider(
          create: (context) => GenreBloc(movieRepositories)..add(FetchGenre()),
        ),
        BlocProvider(
          create: (context) =>
              UpcomingmoviesBloc(movieRepositories)..add(FetchUpComingMovies()),
        ),
        BlocProvider(
          create: (context) =>
              TopratedmoviesBloc(movieRepositories)..add(FetchTopRatedMovies()),
        ),BlocProvider(
          create: (context) =>
              TopRatedTvShowBloc(seriesRepository)..add(FetchTopRatedTvShowEvent()),
        ),BlocProvider(
          create: (context) =>
              AiringtodayBloc(seriesRepository)..add(FetchAiringTodaySeries()),
        ),BlocProvider(
          create: (context) =>
              MovieReviewBloc(movieRepositories),
        ),BlocProvider(
          create: (context) =>
              MovieRecommendationBloc(movieRepositories),
        ),BlocProvider(
          create: (context) =>
              SearchedMovieBloc(movieRepositories),
        ),BlocProvider(
          create: (context) =>
              SearchedTvShowBloc(seriesRepository),
        ),BlocProvider(
          create: (context) =>
              SearchCastBloc(movieRepositories,seriesRepository),
        ),BlocProvider(
          create: (context) =>
              SeriesCreditsBloc(seriesRepository),
        ),
      ],
      child: MaterialApp(

        home: MainScreen(),
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
