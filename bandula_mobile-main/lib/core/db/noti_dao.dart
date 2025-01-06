import 'package:sembast/src/api/filter.dart';
import 'package:bandula/core/db/common/master_dao.dart';
import 'package:bandula/core/viewobject/noti_model.dart';

class NotiDao extends MasterDao<NotiModel> {
  NotiDao._() {
    init(NotiModel());
  }

  // ignore: constant_identifier_names
  static const String STORE_NAME = 'noti_list';
  final String _primaryKey = 'noti_id';

  static final NotiDao _singleton = NotiDao._();

  static NotiDao get instace => _singleton;

  @override
  Filter getFilter(NotiModel object) {
    return Filter.equals(_primaryKey, '');
  }

  @override
  String getPrimaryKey(NotiModel object) {
    return '';
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }
}
