import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/order.dart';

import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../db/order_dao.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import 'Common/master_repository.dart';

class OrderRepository extends MasterRepository {
  OrderRepository(
      {required MasterApiService apiService, required OrderDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;
  late OrderDao _dao;

  Future<dynamic> insert(Order object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Order object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Order object) async {
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
        serverRequestCallback: () async {
          return await _apiService
              .getOrderList(requestPathHolder!.headerToken ?? '');
        });

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  @override
  Future<void> loadData({
    required StreamController<MasterResource<dynamic>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final Finder finder =
        Finder(filter: Filter.equals(primaryKey, requestPathHolder?.itemId));

    await startResourceSinkingForOne(
      dao: _dao,
      streamController: streamController,
      finder: finder,
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return _apiService.getItemDetail(
          requestPathHolder?.itemId,
        );
      },
    );
  }
}
