// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/order.dart';
import 'common/master_dao.dart';

class OrderDao extends MasterDao<Order> {
  OrderDao._() {
    init(Order());
  }

  static const String STORE_NAME = 'order';
  final String _primaryKey = 'order_id';

  // Singleton instance
  static final OrderDao _singleton = OrderDao._();

  // Singleton accessor
  static OrderDao get instance => _singleton;

  @override
  String? getPrimaryKey(Order? object) {
    return object!.orderID;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(Order? object) {
    return Filter.equals(_primaryKey, object!.orderID);
  }
}
