import 'dart:async';

import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/banner_dao.dart';
import '../db/common/master_data_source_manager.dart';
import '../viewobject/banner.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class BannerRepository extends MasterRepository {
  BannerRepository(
      {required MasterApiService apiService, required BannerDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;
  late BannerDao _dao;

  Future<dynamic> insert(HomeBanner object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(HomeBanner object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(HomeBanner object) async {
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
          return _apiService.getHomeBannerList();
        });

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  Future<void> getBannerList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _dao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () async {
          return await _apiService.getHomeBannerList();
        });

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }
}
