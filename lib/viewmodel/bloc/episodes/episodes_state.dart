part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesState {}

final class EpisodesInitial extends EpisodesState {}

final class EpisodesLoading extends EpisodesState {}

final class EpisodesLoaded extends EpisodesState {
  List<EpisodeElement> episodes;
  EpisodesLoaded(this.episodes);
}

final class EpisodesError extends EpisodesState {
  final String errorMsg;
  EpisodesError(this.errorMsg);
}
