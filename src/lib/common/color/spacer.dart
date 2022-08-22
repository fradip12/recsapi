import 'package:flutter/cupertino.dart';

class Spacing {
  static const double kSpacingHeight = 15;

  static getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
}