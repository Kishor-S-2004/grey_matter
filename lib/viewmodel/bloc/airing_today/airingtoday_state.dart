part of 'airingtoday_bloc.dart';

@immutable
sealed class AiringtodayState {}

final class AiringtodayInitial extends AiringtodayState {}

final class AiringtodayLoading extends AiringtodayState {}

final class AiringtodayLoaded extends AiringtodayState {
  final List<AiringTodayResults> results;
  AiringtodayLoaded(this.results);
}

final class AiringtodayError extends AiringtodayState {
  final String errormsg;
  AiringtodayError(this.errormsg);
}
