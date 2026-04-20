import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/view/widgets/tv_show_widgets.dart';

import '../../../viewmodel/bloc/series_season/season_bloc.dart';
import '../../theme/app_theme.dart';
import '../../widgets/tvshowvideo_widgets.dart';

class Series extends StatelessWidget {
  const Series({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TvShowSearchBar(),
            SizedBox(height: 20,),
            CustomText(text: 'Trending Tv Shows', fW: FontWeight.bold, fS: 20),
            SizedBox(height: 12,),
            TrendingSeries(),

            CustomText(text: 'Top Rated Tv Shows', fW: FontWeight.bold, fS: 20),
            SizedBox(height: 12,),
            TvShowList(),


            CustomText(text: 'Popular Tv Shows', fW: FontWeight.bold, fS: 20),
            SizedBox(height: 12,),
            PopularSeries(),

            CustomText(text: 'Airing Today', fW: FontWeight.bold, fS: 20),
            SizedBox(height: 12,),
            AiringTodaySeries(),

          ],
        ),
      ),
    );
  }
}
