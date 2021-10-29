import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:sembast/sembast.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';
import 'package:zdm/datasources/download_datasource.dart';
import 'package:zdm/providers/local_provider.dart';
import 'package:zdm/providers/zippy_provider.dart';
import 'package:zdm/services/downloader_service.dart';

class GlobalBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<Database>(() => LocalProvider.provideDatabase(), tag: "db");
    Get.lazyPut<HttpClient>(() => ZippyProvider());
    Get.lazyPut<ScrapPage>(() => ScrapPage(Get.find()));
    Get.lazyPut<DownloadDataSource>(() => DownloadDataSource(Get.find(tag: "db")));
    Get.put(DownloaderService(zippy: Get.find(), storage: Get.find()));
  }
}