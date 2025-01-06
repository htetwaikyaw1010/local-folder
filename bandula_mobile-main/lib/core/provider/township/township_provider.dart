import 'package:bandula/core/viewobject/township.dart';

import '../../constant/master_constants.dart';
import '../../repository/township_repository.dart';
import '../common/master_provider.dart';

class TownshipProvider extends MasterProvider<Township> {
  TownshipProvider({
    required TownshipRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // ProductRepository? _repo;
  List<Township> get townshipList => super.dataList.data ?? [];
}
