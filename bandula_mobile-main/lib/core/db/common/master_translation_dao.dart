import 'package:sembast/sembast.dart';

import '../../api/common/master_resource.dart';
import '../../api/common/master_status.dart';
import 'master_app_database.dart';

class MasterTranslationDao {
  MasterTranslationDao._() {
    dao = stringMapStoreFactory.store('translation');
  }
  late StoreRef<String?, dynamic> dao;
  static MasterTranslationDao get instance => MasterTranslationDao._();

  Future<Database> get db async => await MasterAppDatabase.instance.database;

  Future<MasterResource<List<Map<String, dynamic>>>> getAll() async {
    final List<RecordSnapshot<String?, dynamic>> recordSnapshots =
        await dao.find(await db);
    // ignore: always_specify_types
    final List<Map<String, dynamic>> langMapList = [<String, dynamic>{}];

    for (RecordSnapshot<String?, dynamic> snapshot in recordSnapshots) {
      langMapList.add(snapshot.value);
    }
    return MasterResource<List<Map<String, dynamic>>>(
        MasterStatus.SUCCESS, '', langMapList);
  }

  Future<MasterResource<Map<String, dynamic>>> getOne(
      String languageCode) async {
    final Finder finder = Finder(filter: Filter.byKey(languageCode));
    final List<RecordSnapshot<String?, dynamic>> recordSnapshots =
        await dao.find(await db, finder: finder);

    Map<String, dynamic> data = <String, dynamic>{};

    for (RecordSnapshot<String?, dynamic> recordSnapshot in recordSnapshots) {
      // if (recordSnapshot.value['language_code'] == languageCode) {
      data = recordSnapshot.value;
      break;
      // }
    }
    return MasterResource<Map<String, dynamic>>(MasterStatus.SUCCESS, '', data);
  }

  Future<MasterResource<Map<String, dynamic>>> getOneByCode(String code) async {
    final Finder finder = Finder(filter: Filter.equals('code', code));
    final List<RecordSnapshot<String?, dynamic>> recordSnapshots =
        await dao.find(await db, finder: finder);

    Map<String, dynamic> data = <String, dynamic>{};

    for (RecordSnapshot<String?, dynamic> recordSnapshot in recordSnapshots) {
      data = recordSnapshot.value;
      break;
    }
    if (data.isEmpty) {
      return MasterResource<Map<String, dynamic>>(MasterStatus.ERROR, '', data);
    } else {
      return MasterResource<Map<String, dynamic>>(
          MasterStatus.SUCCESS, '', data);
    }
  }

  Future<void> insert(
      {required String languageCode,
      required dynamic map,
      required String code}) async {
    final Map<String, dynamic> mapWithCode = map;
    mapWithCode['code'] = code;
    await dao.record(languageCode).put(await db, mapWithCode);
  }

  Future<void> delete({required String languageCode}) async {
    await dao.record(languageCode).delete(await db);
  }

  Future<void> deleteAll() async {
    await dao.delete(await db);
  }
}
