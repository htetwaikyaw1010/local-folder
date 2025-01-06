import 'package:bandula/core/viewobject/payment.dart';

import '../../constant/master_constants.dart';
import '../../repository/payment_repository.dart';
import '../common/master_provider.dart';

class PaymentProvider extends MasterProvider<Payment> {
  PaymentProvider({
    required PaymentRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // ProductRepository? _repo;
  List<Payment> get paymentList => super.dataList.data ?? [];
}
