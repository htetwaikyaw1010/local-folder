import 'dart:async';

import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/brand_dao.dart';
import '../db/common/master_data_source_manager.dart';
import '../viewobject/brand.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class BrandRepository extends MasterRepository {
  BrandRepository(
      {required MasterApiService apiService, required BrandDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;
  late BrandDao _dao;

  Future<dynamic> insert(Brand object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Brand object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Brand object) async {
    return _dao.delete(object);
  }

  @override
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
        serverRequestCallback: () {
          return _apiService.getBarndList(requestPathHolder?.itemId);
        });

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }
}
