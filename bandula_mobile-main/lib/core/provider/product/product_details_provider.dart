import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/product.dart';
import '../common/master_provider.dart';

class ProductDetailProvider extends MasterProvider<Product> {
  ProductDetailProvider({
    required ProductRepository? repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.SINGLE_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // ProductRepository? _repo;
  MasterResource<Product> get itemDetail => super.data;
}
