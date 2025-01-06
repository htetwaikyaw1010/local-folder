// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';

import '../viewobject/user.dart';
import 'common/master_dao.dart';

class UserDao extends MasterDao<User> {
  UserDao._() {
    init(User());
  }

  static const String STORE_NAME = 'user';
  final String _primaryKey = 'id';

  // Singleton instance
  static final UserDao _singleton = UserDao._();

  // Singleton accessor
  static UserDao get instance => _singleton;

  @override
  String? getPrimaryKey(User? object) {
    return object!.userId;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(User? object) {
    return Filter.equals(_primaryKey, object!.userId);
  }
}
