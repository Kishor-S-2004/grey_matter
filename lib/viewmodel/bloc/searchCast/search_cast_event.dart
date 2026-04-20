part of 'search_cast_bloc.dart';

@immutable
sealed class SearchCastEvent {}

class FetchSearchCastEvent extends SearchCastEvent{
  final String personName;
  FetchSearchCastEvent(this.personName);
}
