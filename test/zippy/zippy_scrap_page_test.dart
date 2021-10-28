import 'package:flutter_test/flutter_test.dart';
import 'package:validators/sanitizers.dart';
import 'package:zdm/config/helpers/zippy/parse_page.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'zippy_scrap_page_test.mocks.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

@GenerateMocks([DioClient])
Future<void> main() async {
  final client = new MockDioClient();
  final baseUrl = "https://www85.zippyshare.com";
  final viewPath = baseUrl + "/v/PtNLXyrZ/file.html";
  final dlPath = baseUrl + "/d/PtNLXyrZ/" + toString(34833 % 51245 + 34833 % 913) + "/flutkit-630.rar";
  final file = File(Path.join(Path.current, 'test/data/zippy_success_body.html'));

  test('Shold be able get download link', () async {
    when(client.getBody(viewPath)).thenAnswer((realInvocation) {
      return file.readAsString();
    });
    final scrapper = new ScrapPage(client);
    final link = await scrapper.getLink(viewPath);

    expect(link, isA<ParsePage>());
    expect(link.dlLink, dlPath);
  });
  test('Shold false returned on invalid', () async {
    when(client.getBody(viewPath)).thenAnswer((realInvocation) {
      return Future.value("");
    });
    final scrapper = new ScrapPage(client);
    final link = await scrapper.getLink(viewPath);

    expect(link, false);
  });
}