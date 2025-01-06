import 'dart:async';

import 'package:bandula/core/api/common/master_resource.dart';
import 'package:bandula/core/api/common/master_status.dart';
import 'package:bandula/core/db/common/master_data_source_manager.dart';
import 'package:bandula/core/repository/Common/master_repository.dart';
import 'package:bandula/core/viewobject/blog.dart';
import 'package:bandula/core/viewobject/common/master_holder.dart';
import 'package:bandula/core/viewobject/holder/request_path_holder.dart';

import '../api/master_api_service.dart';
import '../db/blog_dao.dart';

class BlogReposistory extends MasterRepository {
  String primaryKey = 'id';
  late MasterApiService _apiService;
  late BlogDao _dao;

  BlogReposistory(
      {required MasterApiService apiService, required BlogDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  Future<dynamic> insert(Blog object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Blog object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Blog object) async {
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
          return _apiService.getBlogList();
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
      },
    );

    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }
}
