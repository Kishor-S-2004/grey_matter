import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/movie_apiservice.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/repositories/movieReview_repo.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/seriesWatchList_repository.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/screens/authentication/launch_screen.dart';
import 'package:grey_matter/view/screens/authentication/login_screen.dart';
import 'package:grey_matter/view/screens/authentication/register_screen.dart';
import 'package:grey_matter/view/screens/movieScreen/homescreen_view.dart';
import 'package:grey_matter/view/theme/app_theme.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/bottomnavi.dart';
import 'package:grey_matter/viewmodel/bloc/airing_today/airingtoday_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/bottomnavigation/bottom_navigation_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/credits/credits_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/genre/genre_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/movie/movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/movieRecommendations/movie_recommendation_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/movieReview/movie_review_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/nowPlayingMovies/now_playing_movies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/recommendedSeries/recommended_series_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/reviews/movieReviews/moviereviews_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/searchCast/search_cast_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/searchedMovie/searched_movie_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/searchedTvShow/searched_tv_show_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/seriesCredits/series_credits_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/top_rated_tvshow/top_rated_tv_show_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/topratedmovie/topratedmovies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/tvShowVideo/tv_show_video_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/upcomingmovies/upcomingmovies_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/users/userDetails/userdetails_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAVufORl4VmZJObj_JrKOSfoK6KwM173YQ",
      appId: "1:1016125898247:android:8182aea3351db9e1d7f4a2",
      messagingSenderId: '1016125898247',
      projectId: "greymatter-be35c",
      storageBucket: "greymatter-be35c.firebasestorage.app",
    ),
  );
  await dotenv.load(fileName: ".env");
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
  late final MovieRepositories movieRepositories = MovieRepositories(
    movieApiServices,
  );
  late final SeriesRepositories seriesRepository = SeriesRepositories(
    seriesApiServices,
  );



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavigationBloc()),
        BlocProvider(
          create: (context) =>
              MovieBloc(movieRepositories)..add(FetchMovieDetails()),
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
        ),
        BlocProvider(
          create: (context) =>
              TopRatedTvShowBloc(seriesRepository)
                ..add(FetchTopRatedTvShowEvent()),
        ),
        BlocProvider(
          create: (context) =>
              AiringtodayBloc(seriesRepository)..add(FetchAiringTodaySeries()),
        ),
        BlocProvider(create: (context) => MovieReviewBloc(movieRepositories)),
        BlocProvider(
          create: (context) => MovieRecommendationBloc(movieRepositories),
        ),
        BlocProvider(create: (context) => SearchedMovieBloc(movieRepositories)),
        BlocProvider(create: (context) => SearchedTvShowBloc(seriesRepository)),
        BlocProvider(
          create: (context) =>
              SearchCastBloc(movieRepositories, seriesRepository),
        ),
        BlocProvider(create: (context) => SeriesCreditsBloc(seriesRepository)),
        BlocProvider(
          create: (context) =>
              NowPlayingMoviesBloc(movieRepositories)
                ..add(FetchNowPlayingMovies()),
        ),
        BlocProvider(create: (context) => MoviereviewsBloc(MovieReviewRepo())),
        BlocProvider(create: (context) => UserdetailsBloc()),
        BlocProvider(
          create: (context) => RecommendedSeriesBloc(seriesRepository),
        ),
        BlocProvider(
          create: (context) => WatchListBloc(WatchlistRepository())
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true,appBarTheme: const AppBarTheme(
            backgroundColor: Appcolor.background,
            surfaceTintColor: Colors.transparent)),
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,

        home: AnimatedSplashScreen(
          duration: 3500,
          animationDuration: const Duration(milliseconds: 1500),
          backgroundColor: Colors.black,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: FirebaseAuth.instance.currentUser != null
              ? MainScreen()
              : LoginScreen(),

          splash: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/greyMatterLogo.svg", height: 160),
                  const SizedBox(height: 20),
                  Text(
                    'Grey Matter',
                    style: GoogleFonts.gabriela(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Appcolor.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
