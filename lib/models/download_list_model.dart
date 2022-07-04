import 'package:zdm/models/download_model.dart';

class DownloadList {
  DownloadList({
    this.downloads,
  });

  final List<Download>? downloads;

  factory DownloadList.fromJson(List<Map<String, dynamic>> json) {
    final downloads =
        json.map<Download>((download) => Download.fromMap(download)).toList();

    return DownloadList(
      downloads: downloads,
    );
  }
}
