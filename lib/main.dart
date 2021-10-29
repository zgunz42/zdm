import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zdm/app/app.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:zdm/bindings/global_bindings.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true // optional: set false to disable printing logs to console
  );
  await setPreferredOrientations();
  await GlobalBindings().dependencies();
  return runZonedGuarded(() async {
    runApp(ZDMApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
