import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/brand_repository.dart';
import '../../viewobject/brand.dart';
import '../common/master_provider.dart';

class BrandProvier extends MasterProvider<Brand> {
  BrandProvier({
    required BrandRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // BrandRepository? _repo;
  MasterResource<List<Brand>> get gameList => super.dataList;

  bool get isEmpty => super.dataList.data!.isEmpty ? true : false;
  // OrderParameterHolder orderParameterHolder = OrderParameterHolder();
}
