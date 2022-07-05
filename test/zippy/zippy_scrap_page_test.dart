import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart' as Path;
import 'package:validators/sanitizers.dart';
import 'package:zdm/config/helpers/zippy/parse_page.dart';
import 'package:zdm/config/helpers/zippy/scrap_page.dart';
import 'package:zdm/error/invalid_content_error.dart';

import 'zippy_scrap_page_test.mocks.dart';

@GenerateMocks([DioClient])
Future<void> main() async {
  final client = MockDioClient();
  const baseUrl = 'https://www85.zippyshare.com';
  const viewPath = '$baseUrl/v/PtNLXyrZ/file.html';
  final dlPath =
      '$baseUrl/d/PtNLXyrZ/${toString(34833 % 51245 + 34833 % 913)}/%5bKuronime%5d%20RWBYHystsuTkku.01.480p.mp4';
  final file =
      File(Path.join(Path.current, 'test/data/zippy_success_body.html'));
  test('Shold be able get download link', () async {
    when(client.getBody(viewPath)).thenAnswer((realInvocation) {
      return file.readAsString();
    });
    final scrapper = ScrapPage(client);
    final link = await scrapper.getLink(viewPath);

    expect(link.filename, '[Kuronime] RWBYHystsuTkku.01.480p.mp4');
    expect(link, isA<ParsePage>());
    expect(link.dlLink, dlPath);
  });
  test('Shold false returned on invalid', () async {
    when(client.getBody(viewPath)).thenAnswer((realInvocation) {
      return Future.value('');
    });
    final scrapper = ScrapPage(client);
    try {
      await scrapper.getLink(viewPath);
    } catch (e) {
      expect(e, isA<InvalidContentError>());
    }
  });
}
