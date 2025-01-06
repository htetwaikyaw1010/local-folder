import '../../../config/master_config.dart';
import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../db/common/master_data_source_manager.dart';
import '../../repository/product_repository.dart';
// import '../../viewobject/common/master_holder.dart';
// import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/common/master_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/product.dart';
import '../common/master_provider.dart';

class ProductByBrandProvider extends MasterProvider<Product> {
  ProductByBrandProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  ProductRepository? _repo;
  MasterResource<List<Product>> get productList => super.dataList;

  Future<void> loadProductListByBrand({
    bool reset = false,
    required String brandID,
    required String catID,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    if (!reset) {
      cacheBodyHolder = requestBodyHolder;
      cachePathHolder = requestPathHolder;
      cacheDataConfig = dataConfig;
    }
    if (reset) {
      MasterConfig.printLog('🔄 Data Refresh in ($runtimeType) 🔄');
      updateOffset(0);
      if ((cacheDataConfig != null &&
              cacheDataConfig?.dataSourceType ==
                  DataSourceType.SERVER_DIRECT) ||
          (cacheDataConfig == null &&
              defaultDataConfig.dataSourceType ==
                  DataSourceType.SERVER_DIRECT)) {
        dataList.data?.clear();
      }

      if (!isLoading && !isReachMaxData) {
        isLoading = true;
      }
    }

    await _repo?.loadProductListByBrand(
      streamController: dataListStreamController!,
      brandID: brandID,
      catID: catID,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
    );
    notifyListeners();
  }

  Future<void> loadNextProductListByBrand({
    bool reset = false,
    required String brandID,
    required String catID,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    cacheDataConfig = dataConfig;
    await _repo?.loadNextProductListByBrand(
      streamController: dataListStreamController!,
      brandID: brandID,
      catID: catID,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
    );
    notifyListeners();
  }

  Future<void> filterProductListByBrand({
    bool reset = true,
    String? min,
    String? max,
    String? cpu,
    String? generation,
    required String brandID,
    required String catID,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    DataConfiguration? dataConfig,
  }) async {
    if (!reset) {
      cacheBodyHolder = requestBodyHolder;
      cachePathHolder = requestPathHolder;
      cacheDataConfig = dataConfig;
    }
    if (reset) {
      MasterConfig.printLog('🔄 Data Filter in ($runtimeType) 🔄');
      updateOffset(0);
      if ((cacheDataConfig != null &&
              cacheDataConfig?.dataSourceType ==
                  DataSourceType.SERVER_DIRECT) ||
          (cacheDataConfig == null &&
              defaultDataConfig.dataSourceType ==
                  DataSourceType.SERVER_DIRECT)) {
        dataList.data?.clear();
      }

      if (!isLoading && !isReachMaxData) {
        isLoading = true;
      }
    }

    await _repo?.filterProductListByBrand(
      streamController: dataListStreamController!,
      min: min,
      max: max,
      cpu: cpu,
      generation: generation,
      brandID: brandID,
      catID: catID,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
    );
    notifyListeners();
  }

  Future<void> nextFilterProductListByBrand({
    String? min,
    String? max,
    String? cpu,
    String? generation,
    required String brandID,
    required String catID,
    DataConfiguration? dataConfig,
  }) async {
    cacheDataConfig = dataConfig;
    notifyListeners();
    await _repo?.nextFilterProductListByBrand(
      streamController: dataListStreamController!,
      min: min,
      max: max,
      cpu: cpu,
      generation: generation,
      brandID: brandID,
      catID: catID,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
    );
  }
}
