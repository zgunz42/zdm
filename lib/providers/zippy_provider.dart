import 'dart:async';

import 'package:get/get_connect/connect.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';

class ZippyProvider extends GetConnect implements HttpClient {
  @override
  FutureOr<String> getBody(String url) async {
    final data = await get(url);
    return data.bodyString ?? "";
  }
}