import 'package:flutter/foundation.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:sembast/sembast.dart';
import 'package:zdm/config/constants/app_constants.dart';
import 'package:zdm/models/download_list_model.dart';
import 'package:zdm/models/download_model.dart';

class DownloadDataSource {
  final _downloadsStore = intMapStoreFactory.store(ConstVars.STORE_NAME);
  final Database _db;
  DownloadDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Download download) async {
    return await _downloadsStore.add(_db, download.toMap());
  }

  Future<Download?> findByReference(String id) async {
    final recordSnapshot = await _downloadsStore.findFirst(_db,
        finder: Finder(filter: Filter.equals("referenceId", id)));
    if (recordSnapshot != null) {
      return Download.fromMap(recordSnapshot.value);
    }
  }

  Future<int> count() async {
    return await _downloadsStore.count(_db);
  }

  Future<List<Download>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(ConstVars.FIELD_ID)]);

    final recordSnapshots = await _downloadsStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Download> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final data = {...snapshot.value};
      // An ID is a key of a record from the database.
      data.putIfAbsent('id', () => snapshot.key);
      final download = Download.fromMap(data);
      return download;
    }).toList();
  }

  Future<DownloadList?> getDownloadsFromDb() async {
    debugPrint('Loading from database');

    // download list
    DownloadList? downloadsList;

    // fetching data
    final recordSnapshots = await _downloadsStore.find(
      _db,
    );

    // Making a List<Download> out of List<RecordSnapshot>
    if (recordSnapshots.isNotEmpty) {
      downloadsList = DownloadList(
          downloads: recordSnapshots.map((snapshot) {
        final data = {...snapshot.value};
        // An ID is a key of a record from the database.
        data.putIfAbsent('id', () => snapshot.key);
        final download = Download.fromMap(data);
        return download;
      }).toList());
    }

    return downloadsList;
  }

  Future<int> update(Download download) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(download.id));
    return await _downloadsStore.update(
      _db,
      download.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Download download) async {
    final finder = Finder(filter: Filter.byKey(download.id));
    return await _downloadsStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _downloadsStore.drop(
      _db,
    );
  }
}
