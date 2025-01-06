import 'package:bandula/core/repository/generation_repository.dart';

import '../../constant/master_constants.dart';
import '../../viewobject/generation.dart';
import '../common/master_provider.dart';

class GenerationProvier extends MasterProvider<Generation> {
  GenerationProvier({
    required GenerationRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // BrandRepository? _repo;
  List<Generation> get generationList => super.dataList.data ?? [];
}
