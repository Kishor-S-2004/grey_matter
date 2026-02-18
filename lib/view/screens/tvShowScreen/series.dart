import 'package:flutter/material.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';
import 'package:grey_matter/view/widgets/tv_show_widgets.dart';

import '../../theme/app_theme.dart';

class Series extends StatelessWidget {
  const Series({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Appcolor.background,
            title: const Text("TV Shows"),
            floating: true,
            snap: false,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 50.0,left: 20,right: 20,bottom: 20),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(12)
                    ),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500/bsNm9z2TJfe0WO3RedPGWQ8mG1X.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TvShowSearchBar(),
                SizedBox(height: 20,),
                CustomText(text: 'Top Rated Tv Shows', fW: FontWeight.bold, fS: 20),
                TvShowList(),

                CustomText(text: 'Airing Today', fW: FontWeight.bold, fS: 20),
                AiringTodaySeries(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
