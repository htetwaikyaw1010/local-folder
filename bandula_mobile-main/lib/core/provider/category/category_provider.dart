import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/cateogry_repository.dart';
import '../../viewobject/category.dart';
import '../common/master_provider.dart';

class CategoryProvider extends MasterProvider<Category> {
  CategoryProvider({
    required CategoryRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // CategoryRepository? _repo;
  MasterResource<List<Category>> get gameList => super.dataList;
  // OrderParameterHolder orderParameterHolder = OrderParameterHolder();
}
