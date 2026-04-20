part of 'series_credits_bloc.dart';

@immutable
sealed class SeriesCreditsState {}

final class SeriesCreditsInitial extends SeriesCreditsState {}

final class SeriesCreditsLoading extends SeriesCreditsState {}

final class SeriesCreditsLoaded extends SeriesCreditsState {
  final List<SeriesCastResult> seriesCastResult;
  SeriesCreditsLoaded(this.seriesCastResult);
}

final class SeriesCreditsError extends SeriesCreditsState {
  final String message;
  SeriesCreditsError(this.message);
}
