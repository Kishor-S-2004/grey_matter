import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/repositories/authentication_repositories.dart';
import 'package:grey_matter/view/screens/authentication/login_screen.dart';
import 'package:grey_matter/viewmodel/bloc/users/userDetails/userdetails_event.dart';
import 'package:grey_matter/viewmodel/bloc/watchlist/watch_list_event.dart';

import '../../../viewmodel/bloc/users/userDetails/userdetails_bloc.dart';
import '../../../viewmodel/bloc/users/userDetails/userdetails_state.dart';
import '../../../viewmodel/bloc/watchlist/watch_list_bloc.dart';
import '../../theme/appcolor.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    return BlocProvider(
      create: (_) =>
      UserdetailsBloc()..add(UserdetailsEvent.userDetails(userId)),
      child: Scaffold(
        backgroundColor: Appcolor.background,
        appBar: AppBar(
          backgroundColor: Appcolor.background,
          title: Text(
            "Profile",
            style: TextStyle(color: Appcolor.primary),
          ),
          actions: [
            IconButton(onPressed: () async{
              context.read<WatchListBloc>().add(WatchListEvent.watchListInitial());

              await FirebaseAuth.instance.signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                    (route) => false,
              );
            }, icon: Icon(Icons.logout_rounded,color: Appcolor.primary,))
          ],
        ),
        body: BlocBuilder<UserdetailsBloc, UserdetailsState>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserDetailsLoaded) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Appcolor.primary),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.person,
                        color: Appcolor.primary,
                        size: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.userData.Username ?? "Unknown User",
                          style: GoogleFonts.gabriela(
                            fontSize: 22,
                            color: Appcolor.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.userData.email ?? "No Email",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (state is UserDetailsError) {
              return Center(child: Text(state.error));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
