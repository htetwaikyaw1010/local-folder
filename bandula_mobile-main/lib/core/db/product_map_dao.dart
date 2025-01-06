import 'package:sembast/sembast.dart';

import '../viewobject/product_map.dart';
import 'common/master_dao.dart';

class ProductMapDao extends MasterDao<ProductMap> {
  ProductMapDao._() {
    init(ProductMap());
  }
  // ignore: constant_identifier_names
  static const String STORE_NAME = 'ProductMap';
  final String _primaryKey = 'id';

  // Singleton instance
  static final ProductMapDao _singleton = ProductMapDao._();

  // Singleton accessor
  static ProductMapDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(ProductMap object) {
    return object.id;
  }

  @override
  Filter getFilter(ProductMap object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
