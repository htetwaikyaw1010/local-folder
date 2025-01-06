import 'dart:async';

import 'package:sembast/sembast.dart';

import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_data_source_manager.dart';
import '../db/product_dao.dart';
import '../db/product_map_dao.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/product.dart';
import '../viewobject/product_map.dart';
import 'Common/master_repository.dart';

class ProductRepository extends MasterRepository {
  ProductRepository(
      {required MasterApiService apiService, required ProductDao dao}) {
    _apiService = apiService;
    _dao = dao;
  }

  String primaryKey = 'id';
  String mapKey = 'map_key';

  late MasterApiService _apiService;
  late ProductDao _dao;

  late Meta meta = Meta(
    currentPage: 1,
  );

  Future<dynamic> insert(Product object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(Product object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(Product object) async {
    return _dao.delete(object);
  }

  @override
  Future<void> insertToDatabase({required dynamic obj}) async {
    await insert(obj);
  }

  @override
  Future<void> loadDataListFromDatabase({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    await startResourceSinkingForListFromDataBase(
        dao: _dao, streamController: streamController);
  }

  @override
  Future<void> deleteFromDatabase(
      {required StreamController<MasterResource<List<dynamic>>>
          streamController,
      required dynamic obj}) async {
    await delete(obj);
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
          MasterResource<List<Product>> test =
              await _apiService.getlatestProduct('1');
          meta = test.meta!;
          return test;
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

  @override
  Future<void> loadNextDataList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required int limit,
    required int offset,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final String paramKey = requestBodyHolder!.getParamKey();
    final ProductMapDao productMapDao = ProductMapDao.instance;

    int nextPage = 1;
    if (meta.hasMorePage ?? false) {
      nextPage = meta.currentPage! + 1;
      await startResourceSinkingForNextListWithMap<ProductMap>(
        mapObject: ProductMap(),
        mapDao: productMapDao,
        dao: _dao,
        loadingStatus: MasterStatus.PROGRESS_LOADING,
        streamController: streamController,
        dataConfig: dataConfig,
        primaryKey: primaryKey,
        mapKey: mapKey,
        paramKey: paramKey,
        serverRequestCallback: () async {
          MasterResource<List<Product>> test =
              await _apiService.getlatestProduct(nextPage.toString());
          meta = test.meta!;
          return test;
        },
      );
      await subscribeDataListWithMap(
          dataListStream: streamController,
          primaryKey: primaryKey,
          mapKey: mapKey,
          mapObject: ProductMap(),
          paramKey: paramKey,
          dao: _dao,
          statusOnDataChange: MasterStatus.PROGRESS_LOADING,
          dataConfig: dataConfig,
          mapDao: productMapDao);
    }
  }

  Future<void> loadProductListByBrand({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required String brandID,
    required String catID,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _dao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () async {
          MasterResource<List<Product>> test =
              await _apiService.getProductByBrand(brandID, catID, '1');
          meta = test.meta!;
          return test;
        });
    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  Future<void> loadNextProductListByBrand({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required String brandID,
    required String catID,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    final String paramKey = requestBodyHolder!.getParamKey();
    final ProductMapDao productMapDao = ProductMapDao.instance;

    int nextPage = 1;
    if (meta.hasMorePage ?? false) {
      nextPage = meta.currentPage! + 1;
      await startResourceSinkingForNextListWithMap<ProductMap>(
        mapObject: ProductMap(),
        mapDao: productMapDao,
        dao: _dao,
        loadingStatus: MasterStatus.PROGRESS_LOADING,
        streamController: streamController,
        dataConfig: dataConfig,
        primaryKey: primaryKey,
        mapKey: mapKey,
        paramKey: paramKey,
        serverRequestCallback: () async {
          MasterResource<List<Product>> test = await _apiService
              .getProductByBrand(brandID, catID, nextPage.toString());
          meta = test.meta!;
          return test;
        },
      );
      await subscribeDataListWithMap(
          dataListStream: streamController,
          primaryKey: primaryKey,
          mapKey: mapKey,
          mapObject: ProductMap(),
          paramKey: paramKey,
          dao: _dao,
          statusOnDataChange: MasterStatus.PROGRESS_LOADING,
          dataConfig: dataConfig,
          mapDao: productMapDao);
    }
  }

  Future<void> loadSearchProductList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    required String keyword,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _dao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () async {
          MasterResource<List<Product>> test =
              await _apiService.getSearchProductList(keyword, '1');
          meta = test.meta!;
          return test;
        });
    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  Future<void> filterProductList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    String? min,
    String? max,
    String? cpu,
    String? generation,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _dao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () async {
          MasterResource<List<Product>> test =
              await _apiService.filterProductList(
            min: min,
            max: max,
            cpu: cpu,
            generation: generation,
            brandID: 'brandID',
            catID: 'catID',
            page: '1',
          );
          meta = test.meta!;
          return test;
        });
    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  Future<void> nextFilterProductList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    String? min,
    String? max,
    String? cpu,
    String? generation,
    required DataConfiguration dataConfig,
  }) async {
    int nextPage = 1;
    if (meta.hasMorePage ?? false) {
      nextPage = meta.currentPage! + 1;
      await startResourceSinkingForList(
          dao: _dao,
          streamController: streamController,
          dataConfig: dataConfig,
          serverRequestCallback: () async {
            MasterResource<List<Product>> test =
                await _apiService.filterProductList(
                    min: min,
                    max: max,
                    cpu: cpu,
                    generation: generation,
                    brandID: 'brandID',
                    catID: 'catID',
                    page: nextPage.toString());
            meta = test.meta!;
            return test;
          });

      await subscribeDataList(
        dataListStream: streamController,
        dao: _dao,
        statusOnDataChange: MasterStatus.PROGRESS_LOADING,
        dataConfig: dataConfig,
      );
    }
  }

  Future<void> filterProductListByBrand({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    String? min,
    String? max,
    String? cpu,
    String? generation,
    required String brandID,
    required String catID,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    await startResourceSinkingForList(
        dao: _dao,
        streamController: streamController,
        dataConfig: dataConfig,
        serverRequestCallback: () async {
          MasterResource<List<Product>> test =
              await _apiService.filterProductList(
                  min: min,
                  max: max,
                  cpu: cpu,
                  generation: generation,
                  brandID: brandID,
                  catID: catID,
                  page: '1');
          meta = test.meta!;
          return test;
        });
    await subscribeDataList(
      dataListStream: streamController,
      dao: _dao,
      statusOnDataChange: MasterStatus.PROGRESS_LOADING,
      dataConfig: dataConfig,
    );
  }

  Future<void> nextFilterProductListByBrand({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    String? min,
    String? max,
    String? cpu,
    String? generation,
    required String brandID,
    required String catID,
    required DataConfiguration dataConfig,
  }) async {
    int nextPage = 1;
    if (meta.hasMorePage ?? false) {
      nextPage = meta.currentPage! + 1;
      await startResourceSinkingForList(
          dao: _dao,
          streamController: streamController,
          dataConfig: dataConfig,
          serverRequestCallback: () async {
            MasterResource<List<Product>> test =
                await _apiService.filterProductList(
              min: min,
              max: max,
              cpu: cpu,
              generation: generation,
              brandID: brandID,
              catID: catID,
              page: nextPage.toString(),
            );
            meta = test.meta!;
            return test;
          });

      await subscribeDataList(
        dataListStream: streamController,
        dao: _dao,
        statusOnDataChange: MasterStatus.PROGRESS_LOADING,
        dataConfig: dataConfig,
      );
    }
  }
}
