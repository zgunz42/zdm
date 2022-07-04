import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helpers {
  static double percentWidth(BuildContext context, double width) {
    return ((MediaQuery.of(context).size.width) * width) / 100;
  }

  static double percentHeight(BuildContext context, double height) {
    return ((MediaQuery.of(context).size.height) * height) / 100;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
