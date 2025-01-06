import 'dart:async';
import 'dart:core';

import 'package:sembast/sembast.dart';

import '../../api/common/master_resource.dart';
import '../../api/common/master_status.dart';
import '../../viewobject/common/master_map_object.dart';
import '../../viewobject/common/master_object.dart';
import 'master_app_database.dart';

abstract class MasterDao<T extends MasterObject<T>> {
  MasterDao();

  late StoreRef<String?, dynamic> dao;
  late T obj;
  String sortingKey = 'sort';

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get db async => await MasterAppDatabase.instance.database;

  void init(T obj) {
    // A Store with int keys and Map<String, dynamic> values.
    // This Store acts like a persistent map, values of which are Fruit objects converted to Map
    dao = stringMapStoreFactory.store(getStoreName());
    this.obj = obj;
  }

  String getStoreName();

  dynamic getPrimaryKey(T object);
  Filter getFilter(T object);

  Future<dynamic> insert(String primaryKey, T object) async {
    await dao.record(object.getPrimaryKey()).put(await db, obj.toMap(object));
    return true;
  }

  Future<dynamic> insertAll(String primaryKey, List<T> objectList) async {
    final List<String> idList = <String>[];

    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: Finder(),
    );

    int count = recordSnapShots.length;

    for (T data in objectList) {
      idList.add(data.getPrimaryKey() ?? '');
    }
    final List<Map<String, dynamic>?> jsonList = obj.toMapList(objectList);
    for (int i = 0; i < jsonList.length; i++) {
      jsonList[i]![sortingKey] = count++;
    }
    await dao
        .records(idList)
        .put(await db, jsonList); //obj.toMapList(objectList));
  }

  Future<dynamic> update(T object, {Finder? finder}) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    finder ??= Finder(filter: getFilter(object));

    return await dao.update(await db, obj.toMap(object), finder: finder);
  }

  Future<dynamic> updateWithFinder(T object, Finder finder) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    await dao.update(
      await db,
      obj.toMap(object),
      finder: finder,
    );
  }

  Future<dynamic> deleteAll() async {
    await dao.delete(await db);
  }

  Future<dynamic> delete(T object, {Finder? finder}) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    finder ??= Finder(filter: getFilter(object));

    //final Finder finder = Finder(filter: finder);
    await dao.delete(
      await db,
      finder: finder,
    );
  }

  Future<dynamic> deleteWithFinder(Finder finder) async {
    await dao.delete(
      await db,
      finder: finder,
    );
  }

  Future<MasterResource<List<T?>>> getByKey(String key, String value,
      {List<SortOrder>? sortOrderList,
      MasterStatus status = MasterStatus.SUCCESS}) async {
    final Finder finder = Finder(filter: Filter.equals(key, value));
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T?> resultList = <T?>[];
    recordSnapShots.forEach((dynamic snapShot) {
      resultList.add(obj.fromMap(snapShot.value));
    });

    return MasterResource<List<T?>>(status, '', resultList);
  }

  Future<dynamic> getOneWithSubscription(
      {StreamController<MasterResource<T>>? stream,
      Finder? finder,
      MasterStatus status = MasterStatus.SUCCESS,
      Function? onDataUpdated}) async {
    finder ??= Finder();

    final dynamic query = dao.query(finder: finder);
    final dynamic subscription =
        await query.onSnapshots(await db).listen((dynamic recordSnapShots) {
      T? result;

      for (dynamic snapShot in recordSnapShots) {
        final T localObj = obj.fromMap(snapShot.value);
        localObj.key = snapShot.key;
        result = localObj;
        break;
      }
      if (onDataUpdated != null) {
        onDataUpdated(result);
      }
    });

    return subscription;
  }

  Future<dynamic> getAllWithSubscription(
      {StreamController<MasterResource<List<T>>>? stream,
      Finder? finder,
      MasterStatus status = MasterStatus.SUCCESS,
      Function? onDataUpdated}) async {
    finder ??= Finder(sortOrders: <SortOrder>[SortOrder(sortingKey, true)]);

    final dynamic query = dao.query(finder: finder);
    final dynamic subscription =
        await query.onSnapshots(await db).listen((dynamic recordSnapShots2) {
      final List<T> resultList = <T>[];
      recordSnapShots2.forEach((dynamic snapShot) {
        final T localObj = obj.fromMap(snapShot.value);
        localObj.key = snapShot.key;
        resultList.add(localObj);
      });

      if (onDataUpdated != null) {
        onDataUpdated(resultList);
      }
    });

    return subscription;
  }

  Future<dynamic> getAllWithSubscriptionByMap(
      {StreamController<MasterResource<List<T>>>? stream,
      required String primaryKey,
      required String mapKey,
      String? paramKey,
      required MasterDao<MasterObject<dynamic>> mapDao,
      required dynamic mapObj,
      List<SortOrder>? sortOrderList,
      MasterStatus status = MasterStatus.SUCCESS,
      Function? onDataUpdated}) async {
    final MasterResource<List<MasterObject<dynamic>>> dataList =
        await mapDao.getAll(
            finder: Finder(
                filter: Filter.equals(mapKey, paramKey),
                sortOrders: <SortOrder>[SortOrder('sorting', true)]));
    final List<String> valueList = mapObj.getIdList(dataList.data);

    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }
    final dynamic query = dao.query(finder: finder);
    final dynamic subscription = await query
        .onSnapshots(await db)
        .listen((dynamic recordSnapShots2) async {
      if (sortOrderList != null && sortOrderList.isNotEmpty) {
        finder.sortOrders = sortOrderList;
      }

      final dynamic recordSnapShots = await dao.find(
        await db,
        finder: finder,
      );

      final List<T> resultList = <T>[];
      // sorting
      for (String id in valueList) {
        for (dynamic snapShot in recordSnapShots) {
          if (snapShot.value[primaryKey] == id) {
            final T localObj = obj.fromMap(snapShot.value);
            localObj.key = snapShot.key;
            resultList.add(localObj);
            break;
          }
        }
      }
      if (onDataUpdated != null) {
        onDataUpdated(MasterResource<List<T>>(status, '', resultList));
      }
    });
    return subscription;
  }

  Future<dynamic> getAllWithSubscriptionByJoin(
      {StreamController<MasterResource<List<T>>>? stream,
      required String primaryKey,
      required MasterDao<MasterObject<dynamic>> mapDao,
      required dynamic mapObj,
      List<SortOrder>? sortOrderList,
      MasterStatus status = MasterStatus.SUCCESS,
      Function? onDataUpdated}) async {
    final MasterResource<List<MasterObject<dynamic>>> dataList =
        await mapDao.getAll(
            finder:
                Finder(sortOrders: <SortOrder>[SortOrder('sorting', true)]));

    final List<String> valueList = mapObj.getIdList(dataList.data);

    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }
    final dynamic query = dao.query(finder: finder);
    final dynamic subscription = await query
        .onSnapshots(await db)
        .listen((dynamic recordSnapShots2) async {
      if (sortOrderList != null && sortOrderList.isNotEmpty) {
        finder.sortOrders = sortOrderList;
      }

      final dynamic recordSnapShots = await dao.find(
        await db,
        finder: finder,
      );

      final List<T> resultList = <T>[];
      // sorting
      for (String id in valueList) {
        for (dynamic snapShot in recordSnapShots) {
          if (snapShot.value[primaryKey] == id) {
            final T localObj = obj.fromMap(snapShot.value);
            localObj.key = snapShot.key;
            resultList.add(localObj);
            break;
          }
        }
      }
      onDataUpdated!(MasterResource<List<T>>(status, '', resultList));
    });
    return subscription;
  }

  Future<MasterResource<List<T>>> getAll(
      {Finder? finder,
      MasterStatus status = MasterStatus.SUCCESS,
      String message = '',
      List<SortOrder>? sortOrderList}) async {
    // finder ??= Finder(sortOrders: <SortOrder>[SortOrder(sortingKey, true)]);
    if (finder != null) {
      if (sortOrderList == null || sortOrderList.isEmpty) {
        sortOrderList = <SortOrder>[SortOrder(sortingKey, true)];
      } else {
        sortOrderList.add(SortOrder(sortingKey, true));
      }
      finder.sortOrders = sortOrderList;
    } else {
      finder ??= Finder(sortOrders: <SortOrder>[SortOrder(sortingKey, true)]);
    }

    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];
    recordSnapShots.forEach((dynamic snapShot) {
      final T localObj = obj.fromMap(snapShot.value);
      localObj.key = snapShot.key;
      resultList.add(localObj);
    });

    return MasterResource<List<T>>(status, message, resultList);
  }

  Future<MasterResource<T>> getOne(
      {Finder? finder, MasterStatus status = MasterStatus.SUCCESS}) async {
    finder ??= Finder();
    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: finder,
    );
    T? result;

    for (dynamic snapShot in recordSnapShots) {
      final T localObj = obj.fromMap(snapShot.value);
      localObj.key = snapShot.key;
      result = localObj;
      break;
    }

    return MasterResource<T>(status, '', result);
  }

  Future<MasterResource<List<T>>>
      getAllByJoin<K extends MasterMapObject<dynamic, dynamic>>(
          String primaryKey,
          MasterDao<MasterObject<dynamic>> mapDao,
          dynamic mapObj,
          {List<SortOrder>? sortOrderList,
          MasterStatus status = MasterStatus.SUCCESS}) async {
    final MasterResource<List<MasterObject<dynamic>>> dataList =
        await mapDao.getAll(
            finder:
                Finder(sortOrders: <SortOrder>[SortOrder('sorting', true)]));

    final List<String> valueList = mapObj.getIdList(dataList.data);

    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];

    // sorting
    for (String id in valueList) {
      for (dynamic snapShot in recordSnapShots) {
        if (snapShot.value[primaryKey] == id) {
          resultList.add(obj.fromMap(snapShot.value));
          break;
        }
      }
    }

    return MasterResource<List<T>>(status, '', resultList);
  }

  Future<MasterResource<List<T?>>>
      getAllDataListWithFilterId<K extends MasterMapObject<dynamic, dynamic>>(
          String filterId,
          String filterIdKey,
          MasterDao<MasterObject<dynamic>> mapDao,
          dynamic mapObj,
          {List<SortOrder>? sortOrderList,
          MasterStatus status = MasterStatus.SUCCESS}) async {
    final MasterResource<List<MasterObject<dynamic>>> dataList =
        await mapDao.getAll(
            finder: Finder(sortOrders: <SortOrder>[
      SortOrder('sorting', true),
    ], filter: Filter.equals(filterIdKey, filterId)));

    final List<String> valueList = mapObj.getIdList(dataList.data);
    //  code close

    final Finder finder = Finder(
      filter: Filter.inList('id', valueList),
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T?> resultList = <T?>[];

    // sorting
    for (String id in valueList) {
      for (dynamic snapShot in recordSnapShots) {
        if (snapShot.value['id'] == id) {
          resultList.add(obj.fromMap(snapShot.value));
          break;
        }
      }
    }

    return MasterResource<List<T?>>(status, '', resultList);
  }

  Future<MasterResource<List<T>>>
      getAllByMap<K extends MasterMapObject<dynamic, dynamic>>(
          String primaryKey,
          String mapKey,
          String paramKey,
          MasterDao<MasterObject<dynamic>> mapDao,
          dynamic mapObj,
          {List<SortOrder>? sortOrderList,
          MasterStatus status = MasterStatus.SUCCESS}) async {
    final MasterResource<List<MasterObject<dynamic>>> dataList =
        await mapDao.getAll(
            finder: Finder(
                filter: Filter.equals(mapKey, paramKey),
                sortOrders: <SortOrder>[SortOrder('sorting', true)]));

    final List<String> valueList = mapObj.getIdList(dataList.data);

    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
      //sortOrders: [SortOrder(Field.key, true)]
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }

    final dynamic recordSnapShots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];

    // sorting
    for (String id in valueList) {
      for (dynamic snapShot in recordSnapShots) {
        if (snapShot.value[primaryKey] == id) {
          resultList.add(obj.fromMap(snapShot.value));
          break;
        }
      }
    }

    return MasterResource<List<T>>(status, '', resultList);
  }
}
