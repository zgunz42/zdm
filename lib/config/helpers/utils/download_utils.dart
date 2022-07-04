import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'string_utils.dart';

class DownloadUtils {
  static late DateFormat _format;
  static const int MB = 1024 * 1024, KB = 1024;

  static String formatDate(int date) {
    _format = DateFormat("yyyy-MM-dd");
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(date);
    return _format.format(dt);
  }

  static String formatSize(double length) {
    if (length < 0) return "---";
    if (length > MB) {
      return "${(length / MB).toStringAsFixed(1)} MB";
    } else if (length > KB) {
      return "${(length / KB).toStringAsFixed(1)} KB";
    } else {
      return "${(length).toStringAsFixed(1)} B";
    }
  }

  static String getSizeStr(int fileSize) {
    if (fileSize >= 1024 && fileSize < 1048576) {
      return '${(fileSize / 1024).toStringAsFixed(2)} KB';
    } else if (fileSize >= 1048576 && fileSize < 1073741824) {
      return '${(fileSize / 1048576).toStringAsFixed(2)} MB';
    } else {
      return '${(fileSize / 1073741824).toStringAsFixed(2)} G';
    }
  }

  static String getETA(double length, double rate) {
    if (length == 0) return "00:00:00";
    if (length < 1 || rate <= 0) return "---";
    int sec = length ~/ rate;
    return hms(sec);
  }

  static String hms(int sec) {
    int hrs = 0, min = 0;
    hrs = sec ~/ 3600;
    min = (sec % 3600) ~/ 60;
    sec = sec % 60;
    String str =
        "${hrs.toString().padLeft(2)}:${min.toString().padLeft(2)}:${sec.toString().padLeft(2)}";
    return str;
  }

  static String getResolution(String? res) {
    if (res != null) {
      res = res.toLowerCase().trim();
      int index = res.indexOf("x");
      if (index > 0) {
        res = res.substring(index + 1).trim();
        try {
          // toInt(res);
          return res + "p";
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
    throw ArgumentError.value(res);
  }

  static String getFriendlyCodec(String name) {
    if (!StringUtils.isNullOrEmptyOrBlank(name)) {
      name = name.toLowerCase().trim();
      if (name.startsWith("avc")) {
        return "h264";
      }
      if (name.startsWith("mp4a")) {
        return "aac";
      }
      if (name.startsWith("mp4v")) {
        return "mpeg4";
      }
      if (name.startsWith("samr")) {
        return "amr";
      }
    }
    return name;
  }
}
