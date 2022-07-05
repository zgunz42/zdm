import 'package:flutter_test/flutter_test.dart';
import 'package:zdm/config/helpers/zippy/parse_page.dart';
import 'package:zdm/error/invalid_content_error.dart';

void main() {
  group('Download link generator', () {
    late final String htmlPage;
    setUpAll(() {
      htmlPage = """
        <meta property="og:url" content="//www80.zippyshare.com/v/SI3dB2F1/file.html" />
        <script type="text/javascript">
        document.getElementById('dlbutton').href = "/d/SI3dB2F1/" + (536107 % 51245 + 536107 % 913) + "/OReilly.Software.Architecture.The.Hard.Parts.Early.Release.1492086894.rar";
        if (document.getElementById('fimage')) {
        document.getElementById('fimage').href = "/i/SI3dB2F1/" + (536107 % 51245 + 536107 % 913) + "/OReilly.Software.Architecture.The.Hard.Parts.Early.Release.1492086894.rar";
        }
        </script>
        """;
    });
    test('Should generate valid direct link', () {
      final pageParse = ParsePage.findLink(htmlPage);
      final link = pageParse.dlLink;
      const dLink =
          'https://www80.zippyshare.com/d/SI3dB2F1/23833/OReilly.Software.Architecture.The.Hard.Parts.Early.Release.1492086894.rar';

      expect(link, dLink);
    });
    test('Should throw error invalid html', () {
      try {
        ParsePage.findLink('');
      } catch (e) {
        expect(e, isA<InvalidContentError>());
      }
    });
  });
}
