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

class ProductSearchProvider extends MasterProvider<Product> {
  ProductSearchProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  ProductRepository? _repo;
  MasterResource<List<Product>> get gameList => super.dataList;
  // OrderParameterHolder orderParameterHolder = OrderParameterHolder();

  Future<void> loadSearchProductList({
    bool reset = false,
    required String keyword,
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

    await _repo?.loadSearchProductList(
      streamController: dataListStreamController!,
      keyword: keyword,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
    );
    notifyListeners();
  }

  Future<void> filterProductList({
    bool reset = true,
    String? min,
    String? max,
    String? cpu,
    String? generation,
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

    await _repo?.filterProductList(
      streamController: dataListStreamController!,
      min: min,
      max: max,
      cpu: cpu,
      generation: generation,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
      requestBodyHolder: requestBodyHolder ?? cacheBodyHolder,
      requestPathHolder: requestPathHolder ?? cachePathHolder,
    );
    notifyListeners();
  }

  Future<void> nextFilterProductList({
    String? min,
    String? max,
    String? cpu,
    String? generation,
    DataConfiguration? dataConfig,
  }) async {
    cacheDataConfig = dataConfig;
    notifyListeners();
    await _repo?.nextFilterProductList(
      streamController: dataListStreamController!,
      min: min,
      max: max,
      cpu: cpu,
      generation: generation,
      dataConfig: cacheDataConfig ?? dataConfig ?? defaultDataConfig,
    );
  }
}
