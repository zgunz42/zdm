// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:sembast/timestamp.dart';

class Download {
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
  })  : progress = progress ?? 0,
        status = status ?? DownloadTaskStatus.undefined,
        transferRate = transferRate ?? '',
        referenceId = referenceId ?? '';

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

  factory Download.fromMap(Map<String, dynamic> json) => Download(
      id: json['id'] as String,
      name: json['name'] as String,
      size: json['size'] as String,
      timeCreated: (json['timeCreated'] as Timestamp).toDateTime(),
      path: json['path'] as String,
      type: json['type'] as String,
      referenceId: json['referenceId'] as String?,
      transferRate: json['transferRate'] as String?,
      progress: json['progress'] as int?,
      status: DownloadTaskStatus.from(json['status'] as int));

  // ignore: public_member_api_docs, unnecessary_cast
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'size': size,
        'timeCreated': Timestamp.fromDateTime(timeCreated),
        'type': type,
        'path': path,
        'referenceId': referenceId,
        'transferRate': transferRate,
        'status': status.value,
        'progress': progress,
      } as Map<String, dynamic>;
}
