import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:zdm/config/constants/assets.gen.dart';
import 'package:zdm/config/helpers/utils/download_utils.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';
import 'package:zdm/datasources/download_datasource.dart';
import 'package:zdm/models/download_model.dart';

class DownloaderService extends GetxService {
  static DownloaderService get to => Get.find();
  final ScrapPage zippy;
  final DownloadDataSource storage;
  final _port = ReceivePort();

  final tasks = RxList<Download>();
  final permissionReady = false.obs;
  final isLoading = false.obs;
  final localPath = "".obs;

  DownloaderService({required this.zippy, required this.storage});

  @override
  void onInit() {
    super.onInit();
    _bindBackgroundIsolate();
  }

  
  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      try {
        final task = tasks.singleWhere((element) => element.referenceId == id);
        print("$id: $progress and $status");
        task.status = status ?? DownloadTaskStatus.undefined;
        task.progress = progress ?? 0;
        tasks.refresh();
      } catch (e) {
        if(e == StateError) {
          print("unfounded data: $e");
        } else {
          throw e;
        }
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }
    permissionReady.value = hasGranted;
  }

  Future<void> _prepareSaveDir() async {
    localPath.value = (await _findLocalPath())!;
    final savedDir = Directory(localPath.value);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (GetPlatform.isAndroid &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }


  @override
  void onReady() {
    loadTaskData();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void onClose() {
    _unbindBackgroundIsolate();
    _port.close();
    super.onClose();
  }

  Future<void> loadTaskData() async {
    isLoading.value = true;
    final mTasks = await FlutterDownloader.loadTasks();
    final taskData = await storage.getDownloadsFromDb();

    print("task db ${taskData.downloads?.map((e) => [e.id, e.referenceId])}");
    for (var item in mTasks) {
      print("task dl $item ${item.taskId}");
      final taskDownload = await storage.findByReference(item.taskId);
      print("task match $taskDownload");
      if(taskDownload != null) {
        taskDownload.progress = item.progress;
        taskDownload.status = item.status;
        tasks.add(taskDownload);
      }
      FlutterDownloader.resume(taskId: item.taskId);
    }
  }

  Future<String?> _requestDownload(String url, String name) async {
      print("${localPath.value} => $url");
      return await FlutterDownloader.enqueue(
        url: url,
        savedDir: localPath.value,
        fileName: name,
        // show download progress in status bar (for Android)
        showNotification: true,
        // click on notification to open downloaded file (for Android)
        openFileFromNotification: true, 
      );
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<void> download(String link) async {
    final parseResult = await zippy.getLink(link);
    final fileSize = await getFileSize(parseResult.dlLink);

    permissionReady.value = await _checkPermission();
    if (permissionReady.value) {
      await _prepareSaveDir();
      final referenceId = await _requestDownload(parseResult.dlLink, parseResult.filename);
      if (referenceId != null) {
        final willDownload = Download(
          id: Uuid().v4(),
          name: parseResult.filename,
          size: fileSize,
          referenceId: referenceId,
          timeCreated: DateTime.now(),
          type: parseResult.extension,
          path: localPath.value,
        );
        
        await storage.insert(willDownload);
        tasks.add(willDownload);
      } else {
        Get.log("reference id not valid");
      }
    }
  }

  Future<String> getFileSize(String link) async {
    var r = await Dio().head(link);
    final sizeHeader = r.headers.value("content-length");
    final fileSize = int.parse(sizeHeader!);    

    return DownloadUtils.getSizeStr(fileSize);
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
