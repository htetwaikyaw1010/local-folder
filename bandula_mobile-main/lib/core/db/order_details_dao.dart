// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/order_detail.dart';

import 'common/master_dao.dart';

class OrderDetailsDao extends MasterDao<OrderDetails> {
  OrderDetailsDao._() {
    init(OrderDetails());
  }

  static const String STORE_NAME = 'order_details';
  final String _primaryKey = 'order_id';

  // Singleton instance
  static final OrderDetailsDao _singleton = OrderDetailsDao._();

  // Singleton accessor
  static OrderDetailsDao get instance => _singleton;

  @override
  String? getPrimaryKey(OrderDetails? object) {
    return '';
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(OrderDetails? object) {
    return Filter.equals(_primaryKey, '');
  }
}
