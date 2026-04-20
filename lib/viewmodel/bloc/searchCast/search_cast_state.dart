part of 'search_cast_bloc.dart';

@immutable
sealed class SearchCastState {}

final class SearchCastInitial extends SearchCastState {}

final class SearchCastLoading extends SearchCastState {}

final class SearchCastLoaded extends SearchCastState {
  final List<KnownFor> searchCastResult;
  SearchCastLoaded(this.searchCastResult);
}

final class SearchCastError extends SearchCastState {
  final String errorMessage;
  SearchCastError(this.errorMessage);
}
