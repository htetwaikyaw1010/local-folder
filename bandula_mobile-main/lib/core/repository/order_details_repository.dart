import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/master_resource.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../db/order_details_dao.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/order_detail.dart';
import 'Common/master_repository.dart';

class OrderDetailsRepository extends MasterRepository {
  OrderDetailsRepository(
      {required MasterApiService apiService, required OrderDetailsDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;
  late OrderDetailsDao _dao;

  Future<dynamic> insert(OrderDetails object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(OrderDetails object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(OrderDetails object) async {
    return _dao.delete(object);
  }

  @override
  Future<void> loadData({
    required StreamController<MasterResource<dynamic>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final Finder finder =
        Finder(filter: Filter.equals(primaryKey, requestPathHolder?.orderId));

    await startResourceSinkingForOne(
      dao: _dao,
      streamController: streamController,
      finder: finder,
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return _apiService.getOrderDetail(
            orderId: requestPathHolder?.orderId ?? '',
            token: requestPathHolder?.headerToken ?? '');
      },
    );
  }
}
