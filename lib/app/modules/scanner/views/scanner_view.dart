import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zdm/app/modules/root/controllers/root_controller.dart';
import 'package:zdm/app/views/pages/scanner_page.dart';

import '../controllers/scanner_controller.dart';

class ScannerView extends GetView<ScannerController> {
  @override
  Widget build(BuildContext context) {
    RootController rootController = Get.find();
    return Scaffold(
      body: ScannerPage(onFound: (text) {
        Get.log(rootController.link.value);
        rootController.link.value = text;
        Get.back();
      },),
    );
  }
}
