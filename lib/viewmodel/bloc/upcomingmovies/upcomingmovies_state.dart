part of 'upcomingmovies_bloc.dart';

@immutable
sealed class UpcomingmoviesState {}

class UpcomingmoviesInitial extends UpcomingmoviesState {}

class UpcomingMoviesLoading extends UpcomingmoviesState {}

class UpcomingmoviesLoaded extends UpcomingmoviesState {
  final List<Results>? upcomingModel;
  UpcomingmoviesLoaded(this.upcomingModel);
}

class UpcomingmoviesError extends UpcomingmoviesState {
  final String errorMsg;
  UpcomingmoviesError(this.errorMsg);
}
