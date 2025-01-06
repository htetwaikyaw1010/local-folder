// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/payment.dart';
import 'common/master_dao.dart';

class PaymentDao extends MasterDao<Payment> {
  PaymentDao._() {
    init(Payment());
  }

  static const String STORE_NAME = 'Payment';
  final String _primaryKey = 'id';
  // Singleton instance
  static final PaymentDao _singleton = PaymentDao._();

  // Singleton accessor
  static PaymentDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Payment object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(Payment object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
