// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/product.dart';
import 'common/master_dao.dart';

class ProductDao extends MasterDao<Product> {
  ProductDao._() {
    init(Product());
  }

  static const String STORE_NAME = 'Product';
  final String _primaryKey = 'id';
  // Singleton instance
  static final ProductDao _singleton = ProductDao._();

  // Singleton accessor
  static ProductDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Product object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(Product object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
