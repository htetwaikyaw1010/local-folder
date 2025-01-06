import '../../constant/master_constants.dart';
import '../../repository/order_details_repository.dart';
import '../../viewobject/order_detail.dart';
import '../common/master_provider.dart';

class OrderDetailsProvier extends MasterProvider<OrderDetails> {
  OrderDetailsProvier({
    required OrderDetailsRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.SINGLE_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // BrandRepository? _repo;
  OrderDetails get order => super.data.data ?? OrderDetails();
}
