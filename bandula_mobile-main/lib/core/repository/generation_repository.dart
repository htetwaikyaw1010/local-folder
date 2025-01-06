import 'dart:async';
import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../db/generation_dao.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/generation.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class GenerationRepository extends MasterRepository {
  GenerationRepository(
      {required MasterApiService apiService, required GenerationDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;
  late GenerationDao _dao;

  Future<dynamic> insert(Generation object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Generation object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Generation object) async {
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
          return _apiService.getGenerationList();
        });

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }
}
