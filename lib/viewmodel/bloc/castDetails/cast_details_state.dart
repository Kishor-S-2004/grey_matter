part of 'cast_details_bloc.dart';

@immutable
sealed class CastDetailsState {}

final class CastDetailsInitial extends CastDetailsState {}

final class CastDetailsLoading extends CastDetailsState {}

final class CastDetailsLoaded extends CastDetailsState {
  final CastDetails castDetails;
  CastDetailsLoaded(this.castDetails);
}

final class CastDetailsError extends CastDetailsState {
  final String errorMessage;
  CastDetailsError(this.errorMessage);
}
