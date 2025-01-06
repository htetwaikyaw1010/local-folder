import 'dart:async';
import 'package:sembast/sembast.dart';
import '../../api/common/master_resource.dart';
import '../../api/common/master_status.dart';
import '../../db/common/master_dao.dart';
import '../../db/common/master_data_source_manager.dart';
import '../../db/common/master_shared_preferences.dart';
import '../../viewobject/common/master_holder.dart';
import '../../viewobject/common/master_map_object.dart';
import '../../viewobject/holder/request_path_holder.dart';

class MasterRepository {
  dynamic dataListDaoSubscription;
  dynamic dataDaoSubscription;

  Future<void> loadDataList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {}

  Future<dynamic> loadValueHolder() async {
    MasterSharedPreferences.instance.loadValueHolder();
  }

  Future<void> loadNextDataList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {}

  Future<void> loadDataListFromDatabase({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {}

  Future<void> insertToDatabase({
    required dynamic obj,
  }) async {}

  Future<void> deleteFromDatabase({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required dynamic obj,
  }) async {}

  Future<void> loadData({
    required StreamController<MasterResource<dynamic>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {}

  Future<dynamic> postData({
    required MasterHolder<dynamic>? requestBodyHolder,
    required RequestPathHolder? requestPathHolder,
  }) async {}

  void dispose() {
    if (dataListDaoSubscription != null) {
      dataListDaoSubscription.cancel();
    }
    if (dataDaoSubscription != null) {
      dataDaoSubscription.cancel();
    }
  }

  Future<dynamic> subscribeDataList({
    required StreamController<MasterResource<List<dynamic>>> dataListStream,
    required MasterDao<dynamic> dao,
    required MasterStatus statusOnDataChange,
    required DataConfiguration dataConfig,
  }) async {
    if (dataConfig.dataSourceType != DataSourceType.SERVER_DIRECT) {
      dataListDaoSubscription = await dao.getAllWithSubscription(
          status: MasterStatus.SUCCESS,
          onDataUpdated: (List<dynamic>? resultList) {
            // print('***<< Data Updated >>*** ' + paramKey);
            if (statusOnDataChange != MasterStatus.NOACTION) {
              if (resultList != null) {
                dataListStream.sink.add(MasterResource<List<dynamic>>(
                    statusOnDataChange, '', resultList));
              }
            }
          });
    }
  }

  Future<dynamic> subscribeDataListWithMap({
    required StreamController<MasterResource<List<dynamic>>> dataListStream,
    required String primaryKey,
    required String mapKey,
    required MasterMapObject<dynamic, dynamic>? mapObject,
    required String paramKey,
    required MasterDao<dynamic> dao,
    required MasterStatus statusOnDataChange,
    required DataConfiguration dataConfig,
    required MasterDao<MasterMapObject<dynamic, dynamic>> mapDao,
  }) async {
    if (dataConfig.dataSourceType != DataSourceType.SERVER_DIRECT) {
      dataListDaoSubscription = await dao.getAllWithSubscriptionByMap(
          primaryKey: primaryKey,
          mapKey: mapKey,
          paramKey: paramKey,
          mapDao: mapDao,
          mapObj: mapObject,
          status: MasterStatus.SUCCESS,
          onDataUpdated: (MasterResource<List<dynamic>>? resultList) {
            // print('***<< Data Updated >>*** ' + paramKey);
            if (statusOnDataChange != MasterStatus.NOACTION) {
              if (resultList != null) {
                dataListStream.sink.add(MasterResource<List<dynamic>>(
                    statusOnDataChange, '', resultList.data));
              }
            }
          });
    }
  }

  Future<dynamic> subscribeDataListWithJoin({
    required StreamController<MasterResource<List<dynamic>>> dataListStream,
    required String primaryKey,
    required String mapKey,
    required MasterMapObject<dynamic, dynamic>? mapObject,
    required MasterDao<dynamic> dao,
    required MasterStatus statusOnDataChange,
    required DataConfiguration dataConfig,
    required MasterDao<MasterMapObject<dynamic, dynamic>> mapDao,
  }) async {
    if (dataConfig.dataSourceType != DataSourceType.SERVER_DIRECT) {
      dataListDaoSubscription = await dao.getAllWithSubscriptionByJoin(
          primaryKey: primaryKey,
          mapDao: mapDao,
          mapObj: mapObject,
          status: MasterStatus.SUCCESS,
          onDataUpdated: (MasterResource<List<dynamic>>? resultList) {
            if (statusOnDataChange != MasterStatus.NOACTION) {
              if (resultList != null) {
                dataListStream.sink.add(MasterResource<List<dynamic>>(
                    statusOnDataChange, '', resultList.data));
              }
            }
          });
    }
  }

  Future<dynamic> subscribeForOne({
    required StreamController<MasterResource<dynamic>>? dataStream,
    required Finder finder,
    required MasterDao<dynamic> dao,
    required MasterStatus? status,
  }) async {
    dataDaoSubscription = await dao.getOneWithSubscription(
        status: MasterStatus.SUCCESS,
        finder: finder,
        onDataUpdated: (dynamic obj) {
          if (status != null && status != MasterStatus.NOACTION) {
            // print(status);
            dataStream!.sink.add(MasterResource<dynamic>(status, '', obj));
          } else {
            // print('No Action');
          }
        });
  }

  Future<void> startResourceSinkingForNextListWithMap<
      T extends MasterMapObject<dynamic, dynamic>>({
    required MasterDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    required String primaryKey,
    required String mapKey,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    MasterStatus? loadingStatus,
    required String paramKey,
    required MasterMapObject<dynamic, dynamic> mapObject,
    required dynamic streamController,
    required MasterDao<MasterMapObject<dynamic, dynamic>> mapDao,
    required DataConfiguration dataConfig,
  }) async {
    final MasterDataSourceManager dataSourceManager = MasterDataSourceManager(
        dao: dao,
        dataConfig: dataConfig,
        serverRequestCallback: serverRequestCallback,
        finder: finder,
        sortOrderList: sortOrderList,
        loadingStatus: loadingStatus);
    dataSourceManager.manageForDataListWithMap<T>(
      mapDao: mapDao,
      mapKey: mapKey,
      isNextPage: true,
      mapObject: mapObject,
      paramKey: paramKey,
      primaryKey: primaryKey,
      streamController: streamController,
    );
  }

  Future<void> startResourceSinkingForOne(
      {required MasterDao<dynamic> dao,
      Future<dynamic>? Function()? serverRequestCallback,
      required dynamic streamController,
      required DataConfiguration dataConfig,
      Finder? finder,
      List<SortOrder>? sortOrderList,
      MasterStatus? loadingStatus}) async {
    final MasterDataSourceManager dataSourceManager = MasterDataSourceManager(
        dao: dao,
        dataConfig: dataConfig,
        serverRequestCallback: serverRequestCallback,
        finder: finder,
        sortOrderList: sortOrderList,
        loadingStatus: loadingStatus);
    dataSourceManager.manageForData(streamController);
  }

  ///
  /// Get dataList base on [DataConfiguration] , then add dataList to the stream
  ///
  Future<void> startResourceSinkingForList({
    required MasterDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    Future<dynamic>? Function()? serverRequestCallback,
    MasterStatus? loadingStatus,
    required dynamic streamController,
    required DataConfiguration dataConfig,
  }) async {
    final MasterDataSourceManager dataSourceManager = MasterDataSourceManager(
      dao: dao,
      dataConfig: dataConfig,
      sortOrderList: sortOrderList,
      serverRequestCallback: serverRequestCallback,
      finder: finder,
      loadingStatus: loadingStatus,
    );
    dataSourceManager.manageForDataList(
      streamController: streamController,
      isNextPage: false,
    );
  }

  ///
  /// Get dataList base on [DataConfiguration] , then add dataList to the stream
  ///
  Future<void> startResourceSinkingForNextList({
    required MasterDao<dynamic> dao,
    Future<dynamic>? Function()? serverRequestCallback,
    required dynamic streamController,
    List<SortOrder>? sortOrderList,
    MasterStatus? loadingStatus,
    required DataConfiguration dataConfig,
    Finder? finder,
  }) async {
    final MasterDataSourceManager dataSourceManager = MasterDataSourceManager(
      dao: dao,
      dataConfig: dataConfig,
      serverRequestCallback: serverRequestCallback,
      finder: finder,
      sortOrderList: sortOrderList,
      loadingStatus: loadingStatus,
    );
    dataSourceManager.manageForDataList(
      streamController: streamController,
      isNextPage: true,
    );
  }

  ///
  /// Get dataList from [database], then add dataList to stream
  ///
  Future<void> startResourceSinkingForListFromDataBase({
    required MasterDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    required StreamController<MasterResource<List<dynamic>>> streamController,
  }) async {
    final MasterResource<List<dynamic>> dbResource = await dao.getAll(
      finder: finder ?? Finder(),
      sortOrderList: sortOrderList,
      status: MasterStatus.PROGRESS_LOADING,
    );
    streamController.sink.add(dbResource);
  }

  Future<void> startResourceSinkingForListFromDataBaseTest({
    required MasterDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    required StreamController<MasterResource<List<dynamic>>> streamController,
  }) async {
    final MasterResource<List<dynamic>> dbResource = await dao.getAll(
        finder: finder ?? Finder(),
        sortOrderList: sortOrderList,
        status: MasterStatus.PROGRESS_LOADING);
    streamController.sink.add(dbResource);
  }

  ///
  /// Get single Object from database and then add data to stream
  ///
  Future<void> startResourceSinkingForOneFromDataBase({
    required MasterDao<dynamic> dao,
    Finder? finder,
    List<SortOrder>? sortOrderList,
    required StreamController<MasterResource<dynamic>> streamController,
  }) async {
    final MasterResource<dynamic> dbResource = await dao.getOne(
      finder: finder ?? Finder(),
      status: MasterStatus.PROGRESS_LOADING,
    );
    streamController.sink.add(dbResource);
  }

  Future<dynamic> replaceLoginUserToken(String token) async {
    await MasterSharedPreferences.instance.replaceLoginUserToken(
      token,
    );
  }

  Future<dynamic> replaceLoginUserId(String loginUserId) async {
    await MasterSharedPreferences.instance.replaceLoginUserId(
      loginUserId,
    );
  }

  Future<dynamic> replaceLoginUserName(String loginUserName) async {
    await MasterSharedPreferences.instance.replaceLoginUserName(
      loginUserName,
    );
  }

  // Future<dynamic> replaceUserInfo(String userEmail, String userPassword) async {
  //   await MasterSharedPreferences.instance
  //       .setLoginUserData(userEmail, userPassword);
  // }

  Future<dynamic> removeHeaderToken() async {
    await MasterSharedPreferences.instance.removeHeaderToken();
  }
}
