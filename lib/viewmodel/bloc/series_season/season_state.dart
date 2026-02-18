part of 'season_bloc.dart';

@immutable
sealed class SeasonState {}

final class SeasonInitial extends SeasonState {}

final class SeasonLoading extends SeasonState {}

final class SeasonLoaded extends SeasonState {
  List<SeasonElement> seasons;
  SeasonLoaded(this.seasons);

}

final class SeasonError extends SeasonState {
  final String errorMsg;
  SeasonError(this.errorMsg);
}
