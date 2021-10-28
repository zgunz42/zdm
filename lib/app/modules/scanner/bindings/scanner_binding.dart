import 'package:get/get.dart';

import '../controllers/scanner_controller.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerController>(
      () => ScannerController(),
    );
  }
}
