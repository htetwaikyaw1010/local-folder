import 'dart:async';
import 'package:bandula/core/api/common/master_resource.dart';
import 'package:bandula/core/api/common/master_status.dart';
import 'package:bandula/core/api/master_api_service.dart';
import 'package:bandula/core/db/common/master_data_source_manager.dart';
import 'package:bandula/core/db/noti_dao.dart';
import 'package:bandula/core/repository/Common/master_repository.dart';
import 'package:bandula/core/viewobject/api_status.dart';
import 'package:bandula/core/viewobject/common/master_holder.dart';
import 'package:bandula/core/viewobject/holder/request_path_holder.dart';
import 'package:bandula/core/viewobject/noti_model.dart';

class NotiListReposistory extends MasterRepository {
  String primaryKey = "id";
  late MasterApiService _apiService;
  late NotiDao _dao;
  NotiListReposistory(
      {required MasterApiService apiService, required NotiDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  Future<dynamic> insert(NotiModel object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(NotiModel object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(NotiModel object) async {
    return _dao.delete(object);
  }

  Future<MasterResource<ApiStatus>> clearAllNoti(
      {required String token}) async {
    final MasterResource<ApiStatus> resource =
        await _apiService.clearNotiList(token: token);
    if (resource.status == MasterStatus.SUCCESS) {
      return resource;
    } else {
      final Completer<MasterResource<ApiStatus>> completer =
          Completer<MasterResource<ApiStatus>>();
      completer.complete(resource);
      return completer.future;
    }
  }

  @override
  Future<void> loadDataList({
    required StreamController<MasterResource<List>> streamController,
    MasterHolder? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
      dao: _dao,
      streamController: streamController,
      dataConfig: dataConfig,
      serverRequestCallback: () async {
        return await _apiService.getNotiList(
          token: requestPathHolder?.headerToken ?? '',
        );
      },
    );
  }

  Future<MasterResource<NotiModel>> showDetail(int id, String token) async {
    final MasterResource<NotiModel> resource =
        await _apiService.getNotiDetail(token: token, id: id);

    if (resource.status == MasterStatus.SUCCESS) {
      return resource;
    } else {
      final Completer<MasterResource<NotiModel>> completer =
          Completer<MasterResource<NotiModel>>();
      completer.complete(resource);
      return completer.future;
    }
  }
}
