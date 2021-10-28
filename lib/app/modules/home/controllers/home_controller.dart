import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zdm/app/modules/root/controllers/root_controller.dart';
import 'package:zdm/services/downloader_service.dart';

class HomeController extends GetxController {
  final link = "".obs;
  final TextEditingController inputController = TextEditingController();
  final RootController rootController;
  final DownloaderService downloader;

  HomeController({required this.rootController, required this.downloader});
  
  @override
  void onInit() {
    super.onInit();
    ever(rootController.link, (val) {
      inputController.value = TextEditingValue(text: rootController.link.value);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
