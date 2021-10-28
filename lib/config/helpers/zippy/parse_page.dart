import 'package:petitparser/petitparser.dart';
import 'dart:math';

class ParsePage {
  int _htmlId;
  String _endpoint;
  String _fileId;
  String _fileName;

  static final Map<String, ParsePage> _cache =
    <String, ParsePage>{};
  
  ParsePage._internal(this._endpoint, this._fileId, this._fileName, this._htmlId);

  factory ParsePage(String endpoint, String fileId, String fileName,  String htmlIdComp) {
    final builder = ExpressionBuilder();
    builder.group()
    ..primitive(digit()
        .plus()
        .seq(char('.').seq(digit().plus()).optional())
        .flatten()
        .trim()
        .map((a) => num.tryParse(a)))
    ..wrapper(char('(').trim(), char(')').trim(), (String l, num a, String r) => a);
    // negation is a prefix operator
    builder.group()
      ..prefix(char('-').trim(), (String op, num a) => -a);

    // power is right-associative
    builder.group()
      ..right(char('^').trim(), (num a, String op, num b) => pow(a, b));

    // modulus operand
    builder.group()
      ..right(char('%').trim(), (num a, String op, num b) => a % b);
    // multiplication and addition are left-associative
    builder.group()
      ..left(char('*').trim(), (num a, String op, num b) => a * b)
      ..left(char('/').trim(), (num a, String op, num b) => a / b);
    builder.group()
      ..left(char('+').trim(), (num a, String op, num b) => a + b)
      ..left(char('-').trim(), (num a, String op, num b) => a - b);

    final parser = builder.build().end();
    final formula = htmlIdComp.replaceAll(" ", "");
    final mathResult = parser.parse(formula);
    return _cache.putIfAbsent(fileId, () => ParsePage._internal(
      endpoint,
      fileId,
      fileName,
      mathResult.value,
    ));
  }

  static List<String> _url(String html) {
    RegExp urlExp = RegExp(r'(?<=<meta property="og:url" content=")(\/\/w{3}\d{2}.zippyshare\.com)\/\w\/(.*)\/.*(?="\s?\/>)', multiLine: true);
    try {
      List<String?> paths = urlExp.allMatches(html).elementAt(0).groups([1, 2]);

      String? endpoint = paths[0];
      String? fileId = paths[1];

      if(endpoint != null && fileId != null) {
        return [endpoint, fileId];
      }
    } catch (e) {
      if(e is IndexError) {
        throw ArgumentError("endpoint and fileId could't be found", "invalid html");
      } else {
        throw e;
      }
    }
    throw ArgumentError("endpoint and fileId could't be found", "invalid html");
  }

  factory ParsePage.findLink(String html) {
    List<String> result = _url(html);
    RegExp linkExp = RegExp(r'(\/d\/([A-Za-z0-9]*)\/)([\"\s\+\(]+)([\+\d\s+\-*%]+)([\"\s\+\)]+\/)(.*)(?=\";)');
    var matches = linkExp.allMatches(html).elementAt(0);
    List<String?> paths = matches.groups([2,4,6]);
    String? htmlIdComp = paths[1];
    String? fileName = paths[2];
    if(htmlIdComp != null && fileName != null) {
      return ParsePage(result[0], result[1], fileName, htmlIdComp);
    }

    throw ArgumentError("htmlId and file could't be found", "invalid html");
  }

  String get dlLink {
    return 'https:$_endpoint/d/$_fileId/$_htmlId/$_fileName';
  }

  String get filename {
    return _fileName;
  }

  String get extension {
    return _fileName.split(".").last;
  }
}