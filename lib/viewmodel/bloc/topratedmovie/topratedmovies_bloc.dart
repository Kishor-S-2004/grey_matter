import 'package:bloc/bloc.dart';
import 'package:grey_matter/model/movie/toprated_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:meta/meta.dart';

part 'topratedmovies_event.dart';
part 'topratedmovies_state.dart';

class TopratedmoviesBloc extends Bloc<TopratedmoviesEvent, TopratedmoviesState> {
  final MovieRepositories repositories;
  TopratedmoviesBloc(this.repositories) : super(TopratedmoviesInitial()) {
    on<FetchTopRatedMovies>((event, emit) async{
      emit(TopratedmoviesLoading());
      try{
      final topRatedMovies =await repositories.getTopRatedMovies();
      emit(TopratedmoviesLoaded(topRatedMovies.results));
      }catch(e){
        emit(TopratedmoviesError('$e'));
      }
    });
  }
}
