import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:bandula/core/db/region_dao.dart';
import 'package:bandula/core/viewobject/region.dart';
import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class RegionRepository extends MasterRepository {
  RegionRepository(
      {required MasterApiService apiService, required RegionDao dao}) {
    _apiService = apiService;

    _dao = dao;
  }

  String primaryKey = 'region_id';
  late MasterApiService _apiService;
  late RegionDao _dao;

  Future<dynamic> insert(Region object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Region object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Region object) async {
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
          MasterResource<List<Region>> test = await _apiService.getRegionList();
          return test;
        });
    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  // @override
  // Future<void> loadNextDataList({
  //   required StreamController<MasterResource<List<dynamic>>> streamController,
  //   required int limit,
  //   required int offset,
  //   MasterHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  //   required DataConfiguration dataConfig,
  // }) async {
  //   final String paramKey = requestBodyHolder!.getParamKey();
  //   final ProductMapDao productMapDao = ProductMapDao.instance;

  //   int nextPage = 1;
  //   if (meta.hasMorePage ?? false) {
  //     nextPage = meta.currentPage! + 1;
  //     await startResourceSinkingForNextListWithMap<ProductMap>(
  //       mapObject: ProductMap(),
  //       mapDao: productMapDao,
  //       dao: _dao,
  //       loadingStatus: MasterStatus.PROGRESS_LOADING,
  //       streamController: streamController,
  //       dataConfig: dataConfig,
  //       primaryKey: primaryKey,
  //       mapKey: mapKey,
  //       paramKey: paramKey,
  //       serverRequestCallback: () async {
  //         MasterResource<List<Product>> test =
  //             await _apiService.getlatestProduct(nextPage.toString());
  //         meta = test.meta!;
  //         return test;
  //       },
  //     );
  //     await subscribeDataListWithMap(
  //         dataListStream: streamController,
  //         primaryKey: primaryKey,
  //         mapKey: mapKey,
  //         mapObject: ProductMap(),
  //         paramKey: paramKey,
  //         dao: _dao,
  //         statusOnDataChange: MasterStatus.PROGRESS_LOADING,
  //         dataConfig: dataConfig,
  //         mapDao: productMapDao);
  //   }
  // }
}
