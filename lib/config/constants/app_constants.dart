//## Base Constant Config  ----------------------------

import 'dart:ui';

import 'fonts.gen.dart';

const String APP_NAME = "ZDM";
const String BASE_API_URL = "";

//!! Shared Variables  ----------------------------
class ConstVars {
  //# Default Configuration
  //!! language app
  static const Locale defaultLocale = Locale('id', 'ID');
  static const Locale defaultLocaleFallback = Locale('en', 'US');
  //!! style properties
  static const dynamic defaultFont = FontFamily.inter;
  static const dynamic defaultTextScaling =
      0.75; // default text scaling factory (auto resize by font size in the mobile client user)
  //!! dimens
  static const double horizontal_padding = 16.0;
  static const double vertical_padding = 16.0;

  // Store Name
  static const String STORE_NAME = 'zdm';
  // DB Name
  static const DB_NAME = 'zdm.db';
  // Fields
  static const FIELD_ID = 'id';
}