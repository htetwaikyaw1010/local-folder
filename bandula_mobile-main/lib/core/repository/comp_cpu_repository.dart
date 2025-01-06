import 'dart:async';

import 'package:bandula/core/viewobject/comp_cpu.dart';

import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../db/cpu_dao.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class CompCPURepository extends MasterRepository {
  CompCPURepository(
      {required MasterApiService apiService, required CompCPUDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;
  late CompCPUDao _dao;

  Future<dynamic> insert(CompCPU object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(CompCPU object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(CompCPU object) async {
    return _dao.delete(object);
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
        serverRequestCallback: () {
          return _apiService.getCPUList();
        });

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }
}
