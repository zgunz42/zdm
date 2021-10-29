// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sembast/timestamp.dart';

class Download {
  final String id;
  final String name;
  final String size;
  final String type;
  final String path;
  final DateTime timeCreated;
  late String timeLeft;
  late int progress;
  late String referenceId;
  late DownloadTaskStatus status;
  late String transferRate;

  Download({
    required this.id,
    required this.name,
    required this.size,
    required this.timeCreated,
    required this.type,
    required this.path,
    String? referenceId,
    String? transferRate,
    DownloadTaskStatus? status,
    int? progress,
  }): progress = progress ?? 0, status = status ?? DownloadTaskStatus.undefined, transferRate = transferRate ?? "", referenceId = referenceId ?? "";

  factory Download.fromMap(Map<String, dynamic> json) => Download(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        timeCreated: (json["timeCreated"] as Timestamp).toDateTime(),
        path: json["path"],
        type: json["type"],
        referenceId: json["referenceId"],
        transferRate: json["transferRate"],
        progress: json["progress"],
        status: DownloadTaskStatus.from(json["status"])
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "size": size,
        "timeCreated": Timestamp.fromDateTime(timeCreated),
        "type": type,
        "path": path,
        "referenceId": referenceId,
        "transferRate": transferRate,
        "status": status.value,
        "progress": progress,
      };
}