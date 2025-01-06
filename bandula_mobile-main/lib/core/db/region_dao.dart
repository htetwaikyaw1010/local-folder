// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/region.dart';

import 'common/master_dao.dart';

class RegionDao extends MasterDao<Region> {
  RegionDao._() {
    init(Region());
  }

  static const String STORE_NAME = 'Region';
  final String _primaryKey = 'region_id';
  // Singleton instance
  static final RegionDao _singleton = RegionDao._();

  // Singleton accessor
  static RegionDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Region object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(Region object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
