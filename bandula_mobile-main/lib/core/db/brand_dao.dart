// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/brand.dart';
import 'common/master_dao.dart';

class BrandDao extends MasterDao<Brand> {
  BrandDao._() {
    init(Brand());
  }

  static const String STORE_NAME = 'Brand';
  final String _primaryKey = 'id';
  // Singleton instance
  static final BrandDao _singleton = BrandDao._();

  // Singleton accessor
  static BrandDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Brand object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(Brand object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
