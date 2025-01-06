import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/township.dart';

import 'common/master_dao.dart';

class TownshipDao extends MasterDao<Township> {
  TownshipDao._() {
    init(Township());
  }

  // ignore: constant_identifier_names
  static const String STORE_NAME = 'Township';
  final String _primaryKey = 'township_id';
  // Singleton instance
  static final TownshipDao _singleton = TownshipDao._();

  // Singleton accessor
  static TownshipDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Township object) {
    return object.townshipID.toString();
  }

  @override
  Filter getFilter(Township object) {
    return Filter.equals(_primaryKey, object.townshipID);
  }
}
