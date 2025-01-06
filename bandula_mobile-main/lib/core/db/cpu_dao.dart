// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/comp_cpu.dart';
import 'common/master_dao.dart';

class CompCPUDao extends MasterDao<CompCPU> {
  CompCPUDao._() {
    init(CompCPU());
  }

  static const String STORE_NAME = 'CompCPU';
  final String _primaryKey = 'id';
  // Singleton instance
  static final CompCPUDao _singleton = CompCPUDao._();

  // Singleton accessor
  static CompCPUDao get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(CompCPU object) {
    return object.id.toString();
  }

  @override
  Filter getFilter(CompCPU object) {
    return Filter.equals(_primaryKey, object.id);
  }
}
