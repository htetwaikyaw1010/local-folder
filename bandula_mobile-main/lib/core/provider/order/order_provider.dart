import 'package:bandula/core/repository/order_repository.dart';
import 'package:bandula/core/viewobject/order.dart';

import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../common/master_provider.dart';

class OrderProvier extends MasterProvider<Order> {
  OrderProvier({
    required OrderRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // BrandRepository? _repo;
  MasterResource<List<Order>> get orderList => super.dataList;

  List<Order> get pendingOrders {
    List<Order> test = [];
    for (Order order in super.dataList.data!) {
      if (order.order!.status == '0') {
        test.add(order);
      }
    }
    return test;
  }

  bool get hasPendingOrders {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return pendingOrders != null && pendingOrders.isNotEmpty;
    } else {
      return false;
    }
  }

  List<Order> get completeOrders {
    List<Order> test = [];
    for (Order order in super.dataList.data!) {
      if (order.order!.status == '2') {
        test.add(order);
      }
    }
    return test;
  }

  bool get hasCompleteOrders {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return completeOrders != null && completeOrders.isNotEmpty;
    } else {
      return false;
    }
  }

  List<Order> get rejectOrders {
    List<Order> test = [];
    for (Order order in super.dataList.data!) {
      if (order.order!.status == '3') {
        test.add(order);
      }
    }
    return test;
  }

  bool get hasRejectOrders {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return rejectOrders != null && rejectOrders.isNotEmpty;
    } else {
      return false;
    }
  }

  List<Order> get confirmedOrders {
    List<Order> test = [];
    for (Order order in super.dataList.data!) {
      if (order.order!.status == '1') {
        test.add(order);
      }
    }
    return test;
  }

  bool get hasConfirmedOrders {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return confirmedOrders != null && confirmedOrders.isNotEmpty;
    } else {
      return false;
    }
  }

  List<Order> get refundOrders {
    List<Order> test = [];
    for (Order order in super.dataList.data!) {
      if (order.order!.status == '4') {
        test.add(order);
      }
    }
    return test;
  }

  bool get hasRefundOrders {
    if (subscriptionType == MasterConst.LIST_OBJECT_SUBSCRIPTION) {
      return refundOrders != null && refundOrders.isNotEmpty;
    } else {
      return false;
    }
  }
}
