import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_matter/model/common/searchCast_model.dart';
import 'package:grey_matter/view/theme/app_theme.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/movie_details_widgets.dart';
import 'package:grey_matter/viewmodel/bloc/searchCast/search_cast_bloc.dart';

// class CastdetailsView extends StatelessWidget {
//   final String personName;
//   const CastdetailsView({super.key,required this.personName});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Appcolor.background,),
//       body: Column(
//         children: [
//           CastDetails()
//         ],
//       ),
//     );
//   }
// }

class CastdetailsView extends StatefulWidget {
  final String personName;

  const CastdetailsView({super.key, required this.personName});

  @override
  State<CastdetailsView> createState() => _CastdetailsViewState();
}

class _CastdetailsViewState extends State<CastdetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<SearchCastBloc>().add(FetchSearchCastEvent(widget.personName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Appcolor.background),
      body: BlocBuilder<SearchCastBloc, SearchCastState>(
        builder: (context, state) {
          if (state is SearchCastLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SearchCastLoaded) {
            final known = state.searchCastResult;

            return SingleChildScrollView(
              child: Column(
                children: [
                  CastDetails(),
                  CastMovie(knownFor: known),
                ],
              ),
            );
          }

          if (state is SearchCastError) {
            return Center(child: Text(state.errorMessage));
          }

          return const SizedBox();
        },
      ),
    );
  }
}


