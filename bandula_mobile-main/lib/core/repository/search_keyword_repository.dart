import 'dart:async';

import 'package:bandula/core/db/search_keyword_dao.dart';
import 'package:bandula/core/viewobject/search_keyword.dart';

import '../api/common/master_resource.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class SearchKeywordRepository extends MasterRepository {
  SearchKeywordRepository({required SearchKeywordDao dao}) {
    _dao = dao;
  }

  String primaryKey = 'id';
  String mapKey = 'map_key';

  late SearchKeywordDao _dao;

  Future<dynamic> insert(SearchKeyword object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(SearchKeyword object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(SearchKeyword object) async {
    return _dao.delete(object);
  }

  @override
  Future<void> insertToDatabase({required dynamic obj}) async {
    await insert(obj);
  }

  Future<void> updateToDatabase(
      {required StreamController<MasterResource<List<dynamic>>>
          streamController,
      required dynamic obj}) async {
    await update(obj);
  }

  @override
  Future<void> deleteFromDatabase(
      {required StreamController<MasterResource<List<dynamic>>>
          streamController,
      required dynamic obj}) async {
    await delete(obj);
  }

  @override
  Future<void> loadDataListFromDatabase({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    await startResourceSinkingForListFromDataBase(
        dao: _dao, streamController: streamController);
  }
}
