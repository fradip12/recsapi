import 'package:flutter/material.dart';
import 'package:src/common/color/colors.dart';

import '../color/spacer.dart';

class HomeProfile extends StatelessWidget {
  final String name;
  const HomeProfile({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Clr.yellowPrimary,
        ),
        SizedBox(
          width: Spacing.kSpacingHeight,
        ),
        Text('Halo $name !'),
      ],
    );
  }
}
