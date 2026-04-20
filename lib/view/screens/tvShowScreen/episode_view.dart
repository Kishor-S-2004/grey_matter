import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/tv_show_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/episodes/episodes_bloc.dart';

class EpisodeView extends StatelessWidget {
  final int seriesId;
  final String seriesName;
  final int? seasonNumber;
  const EpisodeView({
    super.key,
    required this.seriesId,
    required this.seriesName,
    this.seasonNumber
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.background,
        iconTheme: IconThemeData(color: Appcolor.primary),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Episodes',
          style: GoogleFonts.gabriela(
            color: Appcolor.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<EpisodesBloc, EpisodesState>(
        builder: (context, state) {
          if (state is EpisodesLoading) {
            return SizedBox();
          }
          if (state is EpisodesLoaded) {
            // final episodes = state.episodes;
            return Column(
              children: [
                Expanded(
                  child: EpisodeList(
                    seasonNumber: seasonNumber,
                    episodes: state.episodes,
                    seriesId: seriesId,
                    seriesName: seriesName,
                  ),
                ),
              ],
            );
          }
          if (state is EpisodesError) {
            return Text('Error fetching episodes');
          }
          return SizedBox();
        },
      ),
    );
  }
}
