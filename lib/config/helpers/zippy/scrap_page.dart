import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
      return ParsePage.findLink(await getHtmlContent(url));
    } catch (e) {
      if (e.runtimeType == ArgumentError) {
        debugPrint(e.toString());
      }
      rethrow;
    }
  }
}
