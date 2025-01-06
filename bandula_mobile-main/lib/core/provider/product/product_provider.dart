import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/product_repository.dart';
// import '../../viewobject/common/master_holder.dart';
// import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/product.dart';
import '../common/master_provider.dart';

class ProductProvider extends MasterProvider<Product> {
  ProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // ProductRepository? _repo;
  MasterResource<List<Product>> get gameList => super.dataList;
  // OrderParameterHolder orderParameterHolder = OrderParameterHolder();

  // Future<void> getProductList({
  //   MasterHolder<dynamic>? requestBodyHolder,
  //   RequestPathHolder? requestPathHolder,
  // }) async {
  //   isLoading = true;
  //   await _repo!.getProductList(
  //     streamController: dataListStreamController!,
  //     dataConfig: defaultDataConfig,
  //   );
  //   isLoading = false;
  //   notifyListeners();
  // }
}
