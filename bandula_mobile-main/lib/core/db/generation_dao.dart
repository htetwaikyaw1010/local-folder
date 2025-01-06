// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/generation.dart';
import 'common/master_dao.dart';

class GenerationDao extends MasterDao<Generation> {
  GenerationDao._() {
    init(Generation());
  }

  static const String STORE_NAME = 'generation';
  final String _primaryKey = 'id';
  // Singleton instance
  static final GenerationDao _singleton = GenerationDao._();

  // Singleton accessor
  static GenerationDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(Generation object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(Generation object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
