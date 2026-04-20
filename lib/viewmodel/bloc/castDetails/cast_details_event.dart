part of 'cast_details_bloc.dart';

@immutable
sealed class CastDetailsEvent {}

class FetchCastDetailsEvent extends CastDetailsEvent{
  final int personId;
  FetchCastDetailsEvent(this.personId);
}
