// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/category.dart';
import 'common/master_dao.dart';

class CateogryDao extends MasterDao<Category> {
  CateogryDao._() {
    init(Category());
  }

  static const String STORE_NAME = 'Category';
  final String _primaryKey = 'id';
  // Singleton instance
  static final CateogryDao _singleton = CateogryDao._();

  // Singleton accessor
  static CateogryDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Category object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(Category object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
