// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:sembast/sembast.dart';

import '../../api/common/master_resource.dart';
import '../../api/common/master_status.dart';
import '../../constant/master_constants.dart';
import '../../viewobject/common/master_map_object.dart';
import 'master_dao.dart';

enum DataSourceType { FULL_CACHE, SERVER_DIRECT }

class DataConfiguration {
  DataConfiguration({
    required this.dataSourceType,
    this.storePeriod = const Duration(days: 1),
  });

  final DataSourceType dataSourceType;
  final Duration? storePeriod;
}

class MasterDataSourceManager {
  MasterDataSourceManager({
    required this.dao,
    required this.dataConfig,
    required this.finder,
    required this.sortOrderList,
    required this.serverRequestCallback,
    this.loadingStatus,
  });

  final MasterDao<dynamic> dao;
  final DataConfiguration dataConfig;
  final Finder? finder;
  final List<SortOrder>? sortOrderList;
  final Future<dynamic>? Function()? serverRequestCallback;
  final MasterStatus? loadingStatus;

  // For List with Map
  MasterDao<MasterMapObject<dynamic, dynamic>>? mapDao;
  String? paramKey;
  MasterMapObject<dynamic, dynamic>? mapObject;
  String? mapKey;
  String? primaryKey;
  bool isNextPage = false;

  ///  ------------------------------------Data Manage-----------------------------------------------
  void manageForData(
      StreamController<MasterResource<dynamic>> streamController) {
    _sinkForData(streamController);
  }

  void manageForDataList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required bool isNextPage,
  }) {
    this.isNextPage = isNextPage;
    _sinkForDataList(streamController);
  }

  void manageForDataListWithMap<T extends MasterMapObject<dynamic, dynamic>>({
    required MasterDao<MasterMapObject<dynamic, dynamic>> mapDao,
    required String paramKey,
    required MasterMapObject<dynamic, dynamic> mapObject,
    required String mapKey,
    required bool isNextPage,
    required String primaryKey,
    required StreamController<MasterResource<List<dynamic>>> streamController,
  }) {
    this.isNextPage = isNextPage;
    this.mapDao = mapDao;
    this.paramKey = paramKey;
    this.mapObject = mapObject;
    this.mapKey = mapKey;
    this.primaryKey = primaryKey;
    _sinkForDataListWithMap<T>(streamController);
  }

  void manageForDataListWithJoin<T extends MasterMapObject<dynamic, dynamic>>({
    required MasterDao<MasterMapObject<dynamic, dynamic>> mapDao,
    required MasterMapObject<dynamic, dynamic> mapObject,
    required String mapKey,
    required String primaryKey,
    required bool isNextPage,
    required StreamController<MasterResource<List<dynamic>>> streamController,
  }) {
    this.isNextPage = isNextPage;
    this.mapDao = mapDao;
    this.mapObject = mapObject;
    this.mapKey = mapKey;
    this.primaryKey = primaryKey;
    _sinkForDataListWithJoin<T>(streamController);
  }

  ///  ------------------------------------Resource Sink-----------------------------------------------

  void _sinkForDataListWithMap<T extends MasterMapObject<dynamic, dynamic>>(
      StreamController<MasterResource<List<dynamic>>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForListWithMap<T>(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForListWithMap<T>(streamController);
        break;
      default:
    }
  }

  void _sinkForDataListWithJoin<T extends MasterMapObject<dynamic, dynamic>>(
      StreamController<MasterResource<List<dynamic>>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForListWithJoin<T>(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForListWithJoin<T>(streamController);
        break;
      default:
    }
  }

  void _sinkForDataList(
      StreamController<MasterResource<List<dynamic>>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForList(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForList(streamController);
        break;
      default:
    }
  }

  void _sinkForData(
      StreamController<MasterResource<dynamic>> streamController) {
    switch (dataConfig.dataSourceType) {
      case DataSourceType.FULL_CACHE:
        _fullCacheForOne(streamController);
        break;
      case DataSourceType.SERVER_DIRECT:
        _serverDirectForOne(streamController);
        break;
      default:
    }
  }

  ///  ------------------------------------Implementation -----------------------------------------------

  Future<void> _fullCacheForList(
      StreamController<MasterResource<List<dynamic>>> streamController) async {
    final MasterResource<List<dynamic>> daoResource = await dao.getAll(
      status: MasterStatus.PROGRESS_LOADING,
      finder: finder ?? Finder(),
      sortOrderList: sortOrderList ?? <SortOrder>[],
    );

    streamController.sink.add(daoResource);
    final MasterResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == MasterStatus.SUCCESS) {
      if (!isNextPage) {
        if (finder != null) {
          await dao.deleteWithFinder(finder!);
        } else {
          await dao.deleteAll();
        }
      }
      await dao.insertAll('', serverResource.data!);
    } else {
      if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
        await dao.deleteAll();
      }
    }
    streamController.sink
        .add(await dao.getAll(finder: finder, sortOrderList: sortOrderList));
  }

  Future<void> _serverDirectForList(
      StreamController<MasterResource<List<dynamic>>> streamController) async {
    streamController.sink.add(MasterResource<List<dynamic>>(
        loadingStatus ?? MasterStatus.BLOCK_LOADING, '', <dynamic>[]));

    final MasterResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == MasterStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
      streamController.sink.add(
          MasterResource<List<dynamic>>(MasterStatus.ERROR, '', <dynamic>[]));
    } else if (serverResource.status == MasterStatus.ERROR) {
      streamController.sink.add(
          MasterResource<List<dynamic>>(MasterStatus.ERROR, '', <dynamic>[]));
    }
  }

  Future<void> _fullCacheForListWithMap<
          T extends MasterMapObject<dynamic, dynamic>>(
      StreamController<MasterResource<List<dynamic>>> streamController) async {
    final MasterResource<List<dynamic>> daoResource = await dao.getAllByMap(
        primaryKey!, mapKey!, paramKey!, mapDao!, mapObject,
        status: MasterStatus.PROGRESS_LOADING);

    streamController.sink.add(daoResource);

    final MasterResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == MasterStatus.SUCCESS) {
      // Create Map List
      final List<T> objectMapList = <T>[];
      final MasterResource<List<MasterMapObject<dynamic, dynamic>>>
          existingMapList = await mapDao!
              .getAll(finder: Finder(filter: Filter.equals(mapKey!, paramKey)));

      int i = 0;
      i = existingMapList.data!.length + 1;

      for (dynamic data in serverResource.data!) {
        objectMapList.add(
          mapObject?.fromObject(
            addedDate: DateTime.now().toString(),
            mapKey: paramKey!,
            obj: data,
            sorting: i++,
          ),
        );
      }

      // Delete and Insert Map Dao
      // print('Delete Key $paramKey');
      if (!isNextPage) {
        await mapDao!
            .deleteWithFinder(Finder(filter: Filter.equals(mapKey!, paramKey)));
      }
      // print('Insert All Key $paramKey');
      await mapDao!.insertAll(primaryKey!, objectMapList);

      await dao.insertAll(primaryKey!, serverResource.data!);
    } else {
      if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
        // print('delete all');
        await mapDao!.deleteWithFinder(
          Finder(filter: Filter.equals(mapKey!, paramKey)),
        );
      }
    }

    streamController.sink.add(
      await dao.getAllByMap(
        primaryKey!,
        mapKey!,
        paramKey!,
        mapDao!,
        mapObject,
      ),
    );
  }

  Future<void> _serverDirectForListWithMap<
          T extends MasterMapObject<dynamic, dynamic>>(
      StreamController<MasterResource<List<dynamic>>> streamController) async {
    streamController.sink.add(MasterResource<List<dynamic>>(
        loadingStatus ?? MasterStatus.BLOCK_LOADING, '', <dynamic>[]));

    final MasterResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == MasterStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
      streamController.sink.add(
          MasterResource<List<dynamic>>(MasterStatus.ERROR, '', <dynamic>[]));
    } else if (serverResource.status == MasterStatus.ERROR) {
      streamController.sink.add(
          MasterResource<List<dynamic>>(MasterStatus.ERROR, '', <dynamic>[]));
    }
  }

  Future<void> _fullCacheForListWithJoin<
          T extends MasterMapObject<dynamic, dynamic>>(
      StreamController<MasterResource<List<dynamic>>> streamController) async {
    final MasterResource<List<dynamic>> daoResource = await dao.getAllByJoin(
        primaryKey!, mapDao!, mapObject,
        status: MasterStatus.PROGRESS_LOADING);

    streamController.sink.add(daoResource);
    final MasterResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == MasterStatus.SUCCESS) {
      // Create Map List
      final List<T> objectMapList = <T>[];
      final MasterResource<List<MasterMapObject<dynamic, dynamic>>>
          existingMapList = await mapDao!.getAll();
      int i = 0;
      i = existingMapList.data!.length + 1;
      for (dynamic data in serverResource.data!) {
        objectMapList.add(
          mapObject?.fromObject(
            addedDate: DateTime.now().toString(),
            mapKey: '',
            obj: data,
            sorting: i++,
          ),
        );
      }
      if (!isNextPage) {
        if (finder != null) {
          await mapDao!.deleteWithFinder(finder!);
        } else {
          await mapDao!.deleteAll();
        }
      }
      await mapDao!.insertAll(primaryKey!, objectMapList);

      await dao.insertAll(primaryKey!, serverResource.data!);
    } else {
      if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
        await mapDao!.deleteAll();
      }
    }

    streamController.sink.add(
      await dao.getAllByJoin(
        primaryKey!,
        mapDao!,
        mapObject,
      ),
    );
  }

  Future<void> _serverDirectForListWithJoin<T>(
      StreamController<MasterResource<List<dynamic>>> streamController) async {
    streamController.sink.add(MasterResource<List<dynamic>>(
        loadingStatus ?? MasterStatus.BLOCK_LOADING, '', <dynamic>[]));

    final MasterResource<List<dynamic>> serverResource =
        await serverRequestCallback!.call()!;

    // print('Param Key $paramKey');
    if (serverResource.status == MasterStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
      streamController.sink.add(
          MasterResource<List<dynamic>>(MasterStatus.ERROR, '', <dynamic>[]));
    } else if (serverResource.status == MasterStatus.ERROR) {
      streamController.sink.add(
          MasterResource<List<dynamic>>(MasterStatus.ERROR, '', <dynamic>[]));
    }
  }

  Future<void> _fullCacheForOne(
      StreamController<MasterResource<dynamic>> streamController) async {
    final MasterResource<dynamic> daoResource =
        await dao.getOne(status: MasterStatus.PROGRESS_LOADING, finder: finder);

    streamController.sink.add(daoResource);
    final MasterResource<dynamic> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == MasterStatus.SUCCESS) {
      // if (finder != null) {
      //   await dao.deleteWithFinder(finder!);
      // }
      await dao.insert('', serverResource.data!);
      // } else {
      //   if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
      //     await dao.deleteWithFinder(finder!);
      //   }
    }
    streamController.sink.add(await dao.getOne(finder: finder));
  }

  Future<void> _serverDirectForOne(
      StreamController<MasterResource<dynamic>> streamController) async {
    streamController.sink.add(MasterResource<dynamic>(
        loadingStatus ?? MasterStatus.BLOCK_LOADING, '', null));

    final MasterResource<dynamic> serverResource =
        await serverRequestCallback!.call()!;

    if (serverResource.status == MasterStatus.SUCCESS) {
      streamController.sink.add(serverResource);
    } else {
      if (serverResource.errorCode == MasterConst.TOTALLY_NO_RECORD) {
        streamController.sink
            .add(MasterResource<dynamic>(MasterStatus.ERROR, '', null));
      }
    }
  }
}
