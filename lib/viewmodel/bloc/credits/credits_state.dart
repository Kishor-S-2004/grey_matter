part of 'credits_bloc.dart';

@immutable
sealed class CredtisState {}

final class CredtisInitial extends CredtisState {}

final class CredtisLoading extends CredtisState {}

final class CredtisLoaded extends CredtisState {
  final List<Cast> casts;
  final List<Cast> crew;
  CredtisLoaded(this.casts,this.crew);
}

final class CredtisError extends CredtisState {
  final String errorMsg;
  CredtisError(this.errorMsg);
}
