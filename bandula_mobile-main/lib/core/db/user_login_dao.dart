// import 'package:june_game/core/db/common/master_dao.dart';
// import 'package:sembast/sembast.dart';

// import '../viewobject/user_login.dart';
// import 'common/master_dao.dart';

// class UserLoginDao extends MasterDao<UserLogin> {
//   UserLoginDao._() {
//     init(UserLogin());
//   }

//   static const String STORE_NAME = 'UserLogin';
//   final String _primaryKey = 'user_login_id';

//   // Singleton instance
//   static final UserLoginDao _singleton = UserLoginDao._();

//   // Singleton accessor
//   static UserLoginDao get instance => _singleton;

//   @override
//   String? getPrimaryKey(UserLogin object) {
//     return object.id;
//   }

//   @override
//   String getStoreName() {
//     return STORE_NAME;
//   }

//   @override
//   Filter getFilter(UserLogin object) {
//     return Filter.equals(_primaryKey, object.id);
//   }
// }
