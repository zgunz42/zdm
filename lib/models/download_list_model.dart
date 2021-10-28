import 'download_model.dart';

class DownloadList {
  final List<Download>? downloads;

  DownloadList({
    this.downloads,
  });

  factory DownloadList.fromJson(List<dynamic> json) {
    List<Download> downloads = <Download>[];
    downloads = json.map((download) => Download.fromMap(download)).toList();

    return DownloadList(
      downloads: downloads,
    );
  }
}