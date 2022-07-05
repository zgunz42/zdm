import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zdm/error/invalid_content_error.dart';
import './parse_page.dart';

abstract class HttpClient {
  FutureOr<String> getBody(String url);
}

class DioClient extends HttpClient {
  late Dio _dio;

  Dio get dio => new Dio();

  @override
  FutureOr<String> getBody(String url) async {
    final response = await dio.get<String>(url);
    return response.data ?? '';
  }
}

class ScrapPage {
  HttpClient client;

  ScrapPage(this.client);

  FutureOr<String> getHtmlContent(String url) async {
    try {
      var response = await this.client.getBody(url);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ParsePage> getLink(String url) async {
    try {
      debugPrint(url);
      return ParsePage.findLink(await getHtmlContent(url));
    } catch (e) {
      debugPrint(e.toString());
      if (e.runtimeType == InvalidContentError) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }
}
