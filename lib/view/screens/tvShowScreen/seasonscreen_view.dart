import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/widgets/tv_show_widgets.dart';

import '../../../viewmodel/bloc/series_season/season_bloc.dart';
import '../../theme/appcolor.dart';

class SeasonscreenView extends StatelessWidget {
  final int seriesId;
  final String seriesName;

  const SeasonscreenView({
    super.key,
    required this.seriesId,
    required this.seriesName
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: BlocBuilder<SeasonBloc, SeasonState>(
        builder: (context, state) {
          if (state is SeasonLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SeasonLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: SeasonContainer(
                      seriesId: seriesId,
                      seriesSeason: state.seasons,seriesName: seriesName,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SeasonError) {
            return const Center(child: Text('Error loading seasons'));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
