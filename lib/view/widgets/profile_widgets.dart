import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/view/screens/menu/favMovies_screen.dart';
import 'package:grey_matter/view/screens/menu/watchList_screen.dart';
import 'package:grey_matter/view/theme/appcolor.dart';

import '../screens/menu/userProfile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final profileItems = [
    {'title': 'Profile', 'icon': Icons.person_sharp},
    {'title': 'Watch List', 'icon': Icons.bookmark},
    {'title': 'Favourite Movies', 'icon': Icons.movie},
  ];

  final itemScreens = [
    UserProfile(),
    WatchListScreen(),
    FavMoviesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Appcolor.background,
      width: MediaQuery.of(context).size.width * .5,
      child: Column(
        children: [
          SizedBox(height: 30,),
          Image(image: AssetImage('assets/logoGreyMatter.png'),height: 80,),
          SizedBox(height: 30,),

          Expanded(
            child: ListView.builder(
              itemCount: profileItems.length,
              itemBuilder: (context, index) {
                final item = profileItems[index];
                final sI = itemScreens[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Appcolor.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: Icon(item['icon'] as IconData),
                      title: Text(item['title'] as String),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => sI),
                        );
                      },
                      hoverColor: Appcolor.primary.withOpacity(0.3),
                      iconColor: Appcolor.primary,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
