import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';
import 'package:sizer/sizer.dart';
import 'package:zdm/app/routes/app_pages.dart';
import 'package:zdm/app/views/pages/unknown_route_page.dart';
import 'package:zdm/config/constants/app_constants.dart';
import 'package:zdm/config/constants/app_theme.dart';
import 'package:zdm/config/constants/colors.gen.dart';
import 'package:zdm/config/constants/locales.g.dart';
import 'package:zdm/config/helpers/utils/logger_utils.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';
import 'package:zdm/datasources/download_datasource.dart';
import 'package:zdm/providers/local_provider.dart';
import 'package:zdm/providers/zippy_provider.dart';
import 'package:zdm/services/downloader_service.dart';

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
                initialBinding: BindingsBuilder(
                  () async {
                    await Get.putAsync<Database>(() => LocalProvider.provideDatabase(), tag: "db");
                    Get.lazyPut<HttpClient>(() => ZippyProvider());
                    Get.lazyPut<ScrapPage>(() => ScrapPage(Get.find()));
                    Get.lazyPut<DownloadDataSource>(() => DownloadDataSource(Get.find(tag: "db")));
                    Get.put(DownloaderService(zippy: Get.find(), storage: Get.find()));
                  },
                ),
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
