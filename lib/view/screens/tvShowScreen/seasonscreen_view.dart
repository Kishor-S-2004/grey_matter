import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/widgets/tv_show_widgets.dart';

import '../../../viewmodel/bloc/episodes/episodes_bloc.dart';
import '../../../viewmodel/bloc/series_season/season_bloc.dart';
import '../../theme/appcolor.dart';
import '../../widgets/tvshowvideo_widgets.dart';

// class SeasonscreenView extends StatefulWidget {
//   final int seriesId;
//   final String seriesName;
//   const SeasonscreenView({super.key,required this.seriesId,required this.seriesName});
//
//   @override
//   State<SeasonscreenView> createState() => _SeasonscreenViewState();
// }
//
// class _SeasonscreenViewState extends State<SeasonscreenView> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


class SeasonscreenView extends StatelessWidget {
  final int seriesId;
  final String seriesName;

  const SeasonscreenView({
    super.key,
    required this.seriesId,
    required this.seriesName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Column(
        children: [
          BlocBuilder<SeasonBloc, SeasonState>(
            builder: (context, state) {
              if (state is! SeasonLoaded) return SizedBox();
              final seasonList = state.seasons;
              return SeasonList(
                seasonList: seasonList,
                seriesId: seriesId,
                seriesName: seriesName,
              );
            },
          ),

          Expanded(
            // ✅ MOVE HERE
            child: BlocBuilder<EpisodesBloc, EpisodesState>(
              builder: (context, state) {
                if (state is EpisodesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is EpisodesLoaded) {
                  return EpisodeList(
                    episodes: state.episodes,
                    seriesId: seriesId,
                    seriesName: seriesName,
                  );
                }

                if (state is EpisodesError) {
                  return const Center(
                    child: Text('Error fetching episodes'),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// body: BlocBuilder<SeasonBloc, SeasonState>(
//   builder: (context, state) {
//     if (state is SeasonLoading) {
//       return const Center(child: CircularProgressIndicator(color: Appcolor.primary,));
//     }
//
//     if (state is SeasonLoaded) {
//       return SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height,
//               child: SeasonContainer(
//                 seriesId: seriesId,
//                 seriesSeason: state.seasons,seriesName: seriesName,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     if (state is SeasonError) {
//       return const Center(child: Text('Error loading seasons'));
//     }
//
//     return const SizedBox();
//   },
// ),
