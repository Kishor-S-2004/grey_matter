import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/upcoming_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'upcomingmovies_event.dart';
part 'upcomingmovies_state.dart';

class UpcomingmoviesBloc extends Bloc<UpcomingmoviesEvent, UpcomingmoviesState> {
  final MovieRepositories repositories;
  UpcomingmoviesBloc(this.repositories) : super(UpcomingmoviesInitial()) {
    on<FetchUpComingMovies>((event, emit) async{
      emit(UpcomingMoviesLoading());
      try{
        final upcomingModel = await repositories.getUpComingMovies();
        emit(UpcomingmoviesLoaded(upcomingModel.results));
      }catch (e){
        emit(UpcomingmoviesError('${e}'));
      }
    });
  }
}
