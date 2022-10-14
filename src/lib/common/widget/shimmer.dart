// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    required this.height,
    required this.width,
  }) : shapeBorder = const RoundedRectangleBorder();
  const ShimmerWidget.rectRadius({
    required this.height,
    required this.width,
    required this.shapeBorder,
  });
  const ShimmerWidget.circular({
    required this.height,
    this.shapeBorder = const CircleBorder(),
    required this.width,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[350]!,
        highlightColor: Colors.grey[100]!,
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
