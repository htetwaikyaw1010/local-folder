import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/comp_cpu_repository.dart';
import '../../viewobject/comp_cpu.dart';
import '../common/master_provider.dart';

class CompCPUProvier extends MasterProvider<CompCPU> {
  CompCPUProvier({
    required CompCPURepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // BrandRepository? _repo;
  MasterResource<List<CompCPU>> get gameList => super.dataList;
}
