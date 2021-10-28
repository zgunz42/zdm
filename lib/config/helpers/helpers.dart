import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helpers {
  static percentWidth(BuildContext context, double width) {
    return ((MediaQuery.of(context).size.width) * width) / 100;
  }

  static percentHeight(BuildContext context, double height) {
    return ((MediaQuery.of(context).size.height) * height) / 100;
  }

  static height(BuildContext context) {
    return (MediaQuery.of(context).size.height);
  }

  static width(BuildContext context) {
    return (MediaQuery.of(context).size.width);
  }
}