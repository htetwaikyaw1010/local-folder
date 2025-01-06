import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/township.dart';
import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../db/township_dao.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class TownshipRepository extends MasterRepository {
  TownshipRepository(
      {required MasterApiService apiService, required TownshipDao dao}) {
    _apiService = apiService;

    _dao = dao;
  }

  String primaryKey = 'region_id';
  late MasterApiService _apiService;
  late TownshipDao _dao;

  Future<dynamic> insert(Township object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Township object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Township object) async {
    return _dao.delete(object);
  }

  Future<dynamic> get(String id) async {
    return _dao.getOne(finder: Finder(filter: Filter.byKey(id)));
  }

  @override
  Future<void> loadDataList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _dao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () async {
          MasterResource<List<Township>> test = await _apiService
              .getTownshipList(requestPathHolder!.regionId ?? '');
          return test;
        });
    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }
}
