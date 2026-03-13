import 'package:flutter/material.dart';
import 'package:grey_matter/view/theme/appcolor.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.theaters_outlined,color: Appcolor.primary,size: 70,));
  }
}
