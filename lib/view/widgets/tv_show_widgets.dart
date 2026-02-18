import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/api_service/tv_show_apiservice.dart';
import 'package:grey_matter/model/tvShow/episode_list.dart';
import 'package:grey_matter/model/tvShow/searchTvShow_model.dart';
import 'package:grey_matter/model/tvShow/season_model.dart';
import 'package:grey_matter/repositories/movie_repositories.dart';
import 'package:grey_matter/repositories/series_repositories.dart';
import 'package:grey_matter/view/screens/tvShowScreen/episode_view.dart';
import 'package:grey_matter/view/screens/tvShowScreen/seasonscreen_view.dart';
import 'package:grey_matter/view/screens/tvShowScreen/viewtvshow_view.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/episodes/episodes_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/seriesCredits/series_credits_bloc.dart';
import 'package:grey_matter/viewmodel/bloc/series_season/season_bloc.dart';

import '../../model/tvShow/tvShowVideo_model.dart';
import '../../viewmodel/bloc/airing_today/airingtoday_bloc.dart';
import '../../viewmodel/bloc/credits/credits_bloc.dart';
import '../../viewmodel/bloc/searchedTvShow/searched_tv_show_bloc.dart';
import '../../viewmodel/bloc/top_rated_tvshow/top_rated_tv_show_bloc.dart';
import '../../viewmodel/bloc/tvShowVideo/tv_show_video_bloc.dart';
import '../theme/appcolor.dart';

class TvShowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SeriesRepositories repositories = SeriesRepositories(
      SeriesApiService(),
    );
    // TODO: implement build
    return BlocBuilder<TopRatedTvShowBloc, TopRatedTvShowState>(
      builder: (context, state) {
        if (state is TopRatedTvShowLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TopRatedTvShowLoaded) {
          return SizedBox(
            height: 320,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.top_rated_result.length,
              itemBuilder: (context, index) {
                final series = state.top_rated_result[index];
                final seriesId = series.id;
                final imageUrl = series.posterPath.isNotEmpty
                    ? 'https://image.tmdb.org/t/p/w500${series.posterPath}'
                    : 'https://via.placeholder.com/500x750?text=No+Image';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(13),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      SeasonBloc(repositories)
                                        ..add(FetchSeriesSeasons(seriesId)),
                                  child: SeasonscreenView(
                                    seriesId: seriesId,
                                    seriesName: series.name,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 240,
                            width: MediaQuery.of(context).size.width * .4,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadiusGeometry.circular(12)
                            ),
                            child: Image.network(imageUrl, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .4,
                            child: Text(
                              series.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.gabriela(
                                fontWeight: FontWeight.w600,
                                color: Appcolor.primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        if (state is TopRatedTvShowError) {
          return Text('Cant fetch');
        }
        return SizedBox();
      },
    );
  }
}

class AiringTodaySeries extends StatelessWidget {
  const AiringTodaySeries({super.key});

  @override
  Widget build(BuildContext context) {
    final SeriesRepositories repositories = SeriesRepositories(
      SeriesApiService(),
    );
    return BlocBuilder<AiringtodayBloc, AiringtodayState>(
      builder: (context, state) {
        if (state is AiringtodayLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is AiringtodayLoaded) {
          return SizedBox(
            height: 330,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                final airingTodayResults = state.results[index];
                final seriesId = airingTodayResults.id;
                final posterPath = airingTodayResults.posterPath.isNotEmpty
                    ? 'https://image.tmdb.org/t/p/w500${airingTodayResults.posterPath}'
                    : '';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(13),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      SeasonBloc(repositories)
                                        ..add(FetchSeriesSeasons(seriesId)),
                                  child: SeasonscreenView(
                                    seriesId: seriesId,
                                    seriesName: airingTodayResults.name,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 240,
                            width: MediaQuery.of(context).size.width * .4,
                            child: Image.network(posterPath, fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: Text(
                          '${airingTodayResults.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.gabriela(
                            fontWeight: FontWeight.w600,
                            color: Appcolor.primary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        if (state is AiringtodayError) {
          return Text('Error fetching movies');
        }
        return SizedBox();
      },
    );
  }
}

class SeasonContainer extends StatelessWidget {
  final int seriesId;
  final List<SeasonElement> seriesSeason;
  final String seriesName;

  const SeasonContainer({
    super.key,
    required this.seriesId,
    required this.seriesSeason,
    required this.seriesName,
  });

  @override
  Widget build(BuildContext context) {
    final SeriesRepositories repositories =
    SeriesRepositories(SeriesApiService());

    // Remove season 0 safely (Specials)
    final filteredSeasons = seriesSeason
        .where((season) => season.seasonNumber != 0)
        .toList();

    if (filteredSeasons.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No Seasons Found")),
      );
    }

    return SizedBox(
      height: 280,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredSeasons.length,
        itemBuilder: (context, index) {
          final season = filteredSeasons[index];

          final imageUrl = (season.posterPath != null && season.posterPath!.isNotEmpty)
              ? 'https://image.tmdb.org/t/p/w500${season.posterPath}'
              : 'https://via.placeholder.com/500x750?text=No+Image';

          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: () {
                  if (season.seasonNumber == null) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => EpisodesBloc(repositories)
                          ..add(
                            FetchEpisodesEvent(
                              seriesId,
                              season.seasonNumber!,
                            ),
                          ),
                        child: EpisodeView(
                          seriesId: seriesId,
                          seriesName: seriesName,
                        ),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                        opacity: .3,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Season ${season.seasonNumber ?? ''}',
                            style: GoogleFonts.gabriela(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Episodes: ${season.episodeCount ?? 0}',
                            style: GoogleFonts.gabriela(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            season.overview?.isNotEmpty == true
                                ? season.overview!
                                : "No overview available",
                            maxLines: 13,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.gabriela(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class EpisodeList extends StatefulWidget {
  final List<EpisodeElement>? episodes;
  final int seriesId;
  final String seriesName;
  // final int seasonNumber;

  const EpisodeList({
    super.key,
    this.episodes,
    required this.seriesId,
    required this.seriesName,
  });

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final SeriesRepositories repositories = SeriesRepositories(
      SeriesApiService(),
    );
    return ListView.builder(
      itemCount: widget.episodes?.length ?? 0,
      itemBuilder: (context, index) {
        final bool isExpanded = _expandedIndex == index;
        final episode = widget.episodes![index];
        final imageUrl = episode.stillPath.isNotEmpty
            ? 'https://image.tmdb.org/t/p/w500${episode.stillPath}'
            : 'https://via.placeholder.com/500x750?text=No+Image';

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.tv),
                title: Text(
                  episode.name ?? "No title",
                  style: GoogleFonts.gabriela(),
                ),
                subtitle: Text(
                  "Runtime: ${episode.runtime ?? '-'} min",
                  style: GoogleFonts.gabriela(),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  onPressed: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                ),
              ),

              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        child: Image.network(imageUrl),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        episode.overview ?? "No overview available",
                        style: GoogleFonts.gabriela(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Release Date: ${episode.airDate?.day}-${episode.airDate?.month}-${episode.airDate?.year}",
                        style: GoogleFonts.gabriela(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Runtime: ${episode.runtime ?? '-'} minutes",
                        style: GoogleFonts.gabriela(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              log('Episode Number : ${episode.episodeNumber}');
                              log('Series Id : ${widget.seriesId}');
                              log('Season Number : ${episode.seasonNumber}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) =>
                                        TvShowVideoBloc(repositories)..add(
                                          FetchTvShowVideo(
                                            widget.seriesId,
                                            episode.seasonNumber,
                                            episode.episodeNumber,
                                          ),
                                        ),
                                    child: TvShowPlayingScreen(
                                      seriesId: widget.seriesId,
                                      seriesName: widget.seriesName,
                                      seasonNumber: episode.seasonNumber,
                                      episodeNumber: episode.episodeNumber,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Play',
                              style: GoogleFonts.gabriela(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Appcolor.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
            ],
          ),
        );
      },
    );
  }
}

class TvShowSearchBar extends StatefulWidget {
  const TvShowSearchBar({super.key});

  @override
  State<TvShowSearchBar> createState() => _TvShowSearchBarState();
}

class _TvShowSearchBarState extends State<TvShowSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showDropdown = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final SeriesRepositories repositories = SeriesRepositories(
    SeriesApiService(),
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchedTvShowBloc, SearchedTvShowState>(
      builder: (context, state) {
        List<SearchTvShowResult> results = [];

        if (state is SearchedTvShowLoaded) {
          results = state.tvShowResult;
        }

        return Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search a movie...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _showDropdown = true;
                  context.read<SearchedTvShowBloc>().add(
                    FetchSearchedTvShowEvent(value),
                  );
                  setState(() {});
                } else {
                  _showDropdown = false;
                  setState(() {});
                }
              },
            ),

            if (_showDropdown && results.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final series = results[index];
                    final imageUrl = series.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w200${series.posterPath}'
                        : '';

                    return GestureDetector(
                      onTap: () {
                        // Handle selection: hide dropdown & log movie info
                        _showDropdown = false;
                        _controller.text = series.name!;
                        setState(() {});
                        log(
                          'Selected: ${series.name}, Poster: ${series.posterPath}',
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  SeasonBloc(repositories)
                                    ..add(FetchSeriesSeasons(series.id)),
                              child: SeasonscreenView(
                                seriesId: series.id,
                                seriesName: series.name!,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            if (imageUrl.isNotEmpty)
                              Image.network(
                                imageUrl,
                                height: 50,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                            const SizedBox(width: 10),
                            if (imageUrl.isNotEmpty)
                              Expanded(
                                child: Text(
                                  series.name!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
