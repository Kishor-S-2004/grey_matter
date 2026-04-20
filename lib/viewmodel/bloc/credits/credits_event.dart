part of 'credits_bloc.dart';

@immutable
sealed class CredtisEvent {}

class FetchCreditDetails extends CredtisEvent{
  final int movieId;
  FetchCreditDetails(this.movieId);
}
