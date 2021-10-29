import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:zdm/app/routes/app_pages.dart';
import 'package:zdm/app/views/pages/unknown_route_page.dart';
import 'package:zdm/config/constants/app_constants.dart';
import 'package:zdm/config/constants/app_theme.dart';
import 'package:zdm/config/constants/colors.gen.dart';
import 'package:zdm/config/constants/locales.g.dart';
import 'package:zdm/config/helpers/utils/logger_utils.dart';

class ZDMApp extends StatelessWidget {
  const ZDMApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* Change color statusbar ********
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ColorName.crimsonRed[800]));

    ///* Disable orientation landscape mode ********
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return Sizer(builder: (context, orientation, deviceType) {
              return GetMaterialApp(
                //***  uncomment DevicePreview.appBuilder builder for enable device preview [testing] ---------
                // builder: DevicePreview.appBuilder,
                debugShowCheckedModeBanner: false,
                enableLog: true,
                logWriterCallback: Logger.write,
                title: APP_NAME,
                unknownRoute: GetPage(
                    name: Routes.NOTFOUND, page: () => UnknownRouteScreen()),
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
                // THEME LOADER -------------------
                theme: themeData,
                // LOCALIZATION MULTILANGUAGE LOADER (l10n)-------------
                translationsKeys: AppTranslation.translations,
              );
            });
          },
        );
      },
    );
  }
}
