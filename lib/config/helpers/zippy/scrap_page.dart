import 'dart:async';

import 'package:dio/dio.dart';
import './parse_page.dart';

abstract class HttpClient {
  FutureOr<String> getBody(String url);
}

class DioClient extends HttpClient {
  late Dio _dio;

  Dio get dio => new Dio();

  @override
  FutureOr<String> getBody(String url) async {
    var response = await dio.get(url);
    return response.data;
  }

}

class ScrapPage {
  HttpClient client;

  ScrapPage(this.client);

  getHtmlContent(String url) async {
    try {
      var response = await this.client.getBody(url);
      return response;
    } catch (e) {
      print(e);
      throw e;
    }
  }

   Future<ParsePage> getLink(url) async {
    try {
      return ParsePage.findLink(await this.getHtmlContent(url));
    } catch (e) {
      if(e.runtimeType == ArgumentError) {
        print(e);
      }
      throw e;
    }
  }
}