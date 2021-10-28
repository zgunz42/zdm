import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zdm/config/constants/assets.gen.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';
import 'package:zdm/datasources/download_datasource.dart';
import 'package:zdm/models/download_model.dart';

class DownloaderService extends GetxService {
  static DownloaderService get to => Get.find();
  final ScrapPage zippy;
  final DownloadDataSource storage;

  final _port = ReceivePort();
  final tasks = RxMap<String, Download>();
  // final downloads = RxList<>();
  var downPath = "/storage/emulated/0/Download".obs;
  var isLoading = false.obs;

  DownloaderService({required this.zippy, required this.storage});

  @override
  void onInit() {
    super.onInit();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      final task = tasks[id];
      print("$id: $progress and $status");
      if (task != null) {
        final task = tasks[id];
        task?.status = status;
        task?.progress = progress;
      }
    });
    loadTaskData();
    // FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void onClose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _port.close();
    super.onClose();
  }

  Future<void> loadTaskData() async {
    isLoading.value = true;
    final mTasks = await FlutterDownloader.loadTasks();
    if (mTasks != null) {
      for (var item in mTasks) {
        final taskDownload = await storage.findByReference(item.taskId);
        if(taskDownload != null) {
          taskDownload.progress = item.progress;
          taskDownload.status = item.status;
          tasks.assign(item.taskId, taskDownload);
        }
      }
    }
  }

  Future<String?> _saveFile(String url) async {
    // String path = await ExtStorage.getExternalStoragePublicDirectory(
    //     ExtStorage.DIRECTORY_DOWNLOADS);
    String? referenceId;
    Directory dir = Directory(downPath.value);
    //start download

    final storagePermission = await Permission.storage.request();
    if (storagePermission.isGranted) {

      referenceId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: dir.path,
        saveInPublicStorage: true,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
    print("start with id: $referenceId from $url");
    return referenceId;
  }

  void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<void> download(String link) async {
    final parseResult = await zippy.getLink(link);
    final fileSize = await getFileSize(parseResult.dlLink);
    final referenceId = await _saveFile(parseResult.dlLink);

    if (referenceId != null) {
      final willDownload = Download(
        name: "name",
        size: fileSize,
        timeCreated: DateTime.now(),
        type: parseResult.extension,
        path: downPath.value,
      );
      final dbIndex = await storage.insert(willDownload);
      willDownload.id = dbIndex;

      tasks.assign(referenceId, willDownload);
    } else {
      Get.log("reference id not valid");
    }
  }

  Future<String> getFileSize(String link) async {
    String size;
    var r = await Dio().head(link);
    final sizeHeader = r.headers.value("content-length");
    final fileSize = int.parse(sizeHeader!);
    if (fileSize >= 1024 && fileSize < 1048576) {
      size = '${(fileSize / 1024).toStringAsFixed(2)} KB';
    } else if (fileSize >= 1048576 && fileSize < 1073741824) {
      size = '${(fileSize / 1048576).toStringAsFixed(2)} MB';
    } else {
      size = '${(fileSize / 1073741824).toStringAsFixed(2)} G';
    }

    return size;
  }

  SvgGenImage getImageFile(type) {
    final SvgGenImage icon = type == 'pdf'
        ? Assets.images.icons.pdf
        : type == 'txt'
            ? Assets.images.icons.txt
            : type == 'docx' || type == 'doc'
                ? Assets.images.icons.doc
                : type == 'zip' || type == 'rar'
                    ? Assets.images.icons.zip
                    : type == 'iso'
                        ? Assets.images.icons.iso
                        : type == 'tif' ||
                                type == 'jpg' ||
                                type == 'gif' ||
                                type == 'png' ||
                                type == 'raw'
                            ? Assets.images.icons.jpg
                            : type == 'flv' ||
                                    type == 'avi' ||
                                    type == 'mov' ||
                                    type == 'mpeg' ||
                                    type == 'mp4' ||
                                    type == 'ogg' ||
                                    type == 'wmv' ||
                                    type == 'webm' ||
                                    type == '3gp'
                                ? Assets.images.icons.video
                                : type == 'mp3' ||
                                        type == 'wma' ||
                                        type == 'mid' ||
                                        type == 'wav'
                                    ? Assets.images.icons.music
                                    : Assets.images.icons.text;
    return icon;
  }
}
