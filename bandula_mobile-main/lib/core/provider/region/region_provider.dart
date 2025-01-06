import 'package:bandula/core/repository/region_repository.dart';
import 'package:bandula/core/viewobject/region.dart';

import '../../constant/master_constants.dart';
import '../common/master_provider.dart';

class RegionProvider extends MasterProvider<Region> {
  RegionProvider({
    required RegionRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // ProductRepository? _repo;
  List<Region> get regionList => super.dataList.data ?? [];
}
