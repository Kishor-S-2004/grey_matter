import 'package:flutter/material.dart';
import 'package:grey_matter/view/widgets/homescreen_widgets.dart';

class ShowDetailContainer extends StatelessWidget {
  const ShowDetailContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width/4,
            height: 250,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Show Name', fW: FontWeight.bold, fS: 20,color: Colors.black,),
                CustomText(text: 'Release Date', fW: FontWeight.w400, fS: 13,color: Colors.black,),
                CustomText(text: 'Duration', fW: FontWeight.w400, fS: 13,color: Colors.black,),
                CustomText(text: 'Genre', fW: FontWeight.w400, fS: 13,color: Colors.black,),
              ],
            ),
          ),
          // MovieList()
        ],
      ),
    );
  }
}
