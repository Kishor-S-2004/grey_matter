import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/view/screens/movieScreen/homescreen_view.dart';
import 'package:grey_matter/view/screens/tvShowScreen/series.dart';
import 'package:grey_matter/view/screens/setting_view.dart';

import '../../viewmodel/bloc/bottomnavigation/bottom_navigation_bloc.dart';
import '../screens/search_view.dart';
import '../theme/appcolor.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static final pages = [
    HomescreenView(),
    Series(),
    SearchView(),
    SettingView(),
  ];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        final currentIndex =
            (state as BottomNavigationInitial).currentIndex;

        return Scaffold(
          body: pages[currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              context
                  .read<BottomNavigationBloc>()
                  .add(ChangeTab(index));
            },
            showSelectedLabels: true,
            selectedItemColor:  Color(0xFFE7BC0F),
            selectedLabelStyle: TextStyle(color: Colors.white),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie,color: currentIndex == 0 ? Appcolor.primary : Colors.grey,),
                label: 'Movies',

              ), BottomNavigationBarItem(
                icon: Icon(Icons.tv,color: currentIndex == 1? Appcolor.primary : Colors.grey,),
                label: 'TV Show',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,color:  currentIndex == 2 ? Appcolor.primary : Colors.grey,),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color:  currentIndex == 3 ? Appcolor.primary : Colors.grey,),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
