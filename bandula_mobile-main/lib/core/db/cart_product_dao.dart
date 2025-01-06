// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/cart_product.dart';

import 'common/master_dao.dart';

class CartProductDao extends MasterDao<CartProduct> {
  CartProductDao._() {
    init(CartProduct());
  }

  static const String STORE_NAME = 'CardProduct';
  final String _primaryKey = 'id';
  // Singleton instance
  static final CartProductDao _singleton = CartProductDao._();

  // Singleton accessor
  static CartProductDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(CartProduct object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(CartProduct object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
