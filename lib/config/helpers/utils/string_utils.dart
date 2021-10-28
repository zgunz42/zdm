import 'dart:convert';

class StringUtils {
	static bool isNullOrEmpty(String? str) {
		return str == null || str.length < 1;
	}

	static bool isNullOrEmptyOrBlank(String? str) {
		return str == null || str.trim().length < 1;
	}

	static List<int> getBytes({StringBuffer? sb, String? s}) {
    if(sb != null) {
      return utf8.encode(sb.toString());
    }
    if(s != null) {
      return utf8.encode(s);
    }
    throw ArgumentError.notNull("sb or s can\'t be null");
	}
}