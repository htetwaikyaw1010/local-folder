import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/master_constants.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/master_value_holder.dart';

class MasterSharedPreferences {
  MasterSharedPreferences._() {
    Utils.masterPrint('init MasterSharePerference $hashCode');
    futureShared = SharedPreferences.getInstance();
    futureShared.then((SharedPreferences shared) {
      this.shared = shared;
      loadValueHolder();
    });
  }

  late Future<SharedPreferences> futureShared;
  late SharedPreferences shared;

  // Singleton instance
  static final MasterSharedPreferences _singleton = MasterSharedPreferences._();

  // Singleton accessor
  static MasterSharedPreferences get instance => _singleton;

  final StreamController<MasterValueHolder> _valueController =
      StreamController<MasterValueHolder>();

  Stream<MasterValueHolder> get masterValueHolder => _valueController.stream;

  void loadValueHolder() {
    final String? token =
        shared.getString(MasterConst.VALUE_HOLDER__USER_TOKEN);
    final String? loginUserId =
        shared.getString(MasterConst.VALUE_HOLDER__USER_ID);
    final String? loginUserName =
        shared.getString(MasterConst.VALUE_HOLDER__USER_NAME);
    final String? loginUserCredential =
        shared.getString(MasterConst.VALUE_HOLDER__USER_CREDENTIAL);
    final String? loginUserPhoto =
        shared.getString(MasterConst.VALUE_HOLDER__USER_PHOTO);
    final String? loginUserEmail =
        shared.getString(MasterConst.VALUE_HOLDER__USER_EMAIL);
    final String? fcmToken =
        shared.getString(MasterConst.VALUE_HOLDER__USER_FCMTOKEN);
    final MasterValueHolder valueHolder = MasterValueHolder(
      loginUserToken: token,
      loginUserId: loginUserId,
      loginUserName: loginUserName,
      loginUsercredentials: loginUserCredential,
      loginUserPhoto: loginUserPhoto,
      loginUserEmail: loginUserEmail,
      fcmToken: fcmToken,
    );

    _valueController.add(valueHolder);
  }

  Future<dynamic> replaceLoginUserToken(String token) async {
    await shared.setString(MasterConst.VALUE_HOLDER__USER_TOKEN, token);
  }

  Future<dynamic> replaceLoginUserId(String loginUserId) async {
    await shared.setString(MasterConst.VALUE_HOLDER__USER_ID, loginUserId);
  }

  Future<dynamic> replaceLoginUserName(String loginUserName) async {
    await shared.setString(MasterConst.VALUE_HOLDER__USER_NAME, loginUserName);
  }

  Future<dynamic> replaceHeaderToken(String headerToken) async {
    await shared.setString(MasterConst.VALUE_HOLDER__HEADER_TOKEN, headerToken);
  }

  Future<String?> getHeaderToken() async {
    return shared.getString(MasterConst.VALUE_HOLDER__HEADER_TOKEN);
  }

  Future<dynamic> setLoginUserData(
    String token,
    String name,
    String id,
    String phone,
    String email,
  ) async {
    await shared.setString(MasterConst.VALUE_HOLDER__USER_TOKEN, token);
    await shared.setString(MasterConst.VALUE_HOLDER__USER_NAME, name);
    await shared.setString(MasterConst.VALUE_HOLDER__USER_ID, id);
    await shared.setString(MasterConst.VALUE_HOLDER__PHONE_ID, phone);
    await shared.setString(MasterConst.VALUE_HOLDER__USER_EMAIL, email);

    loadValueHolder();
  }

  Future<dynamic> setLoginFcmToken(
    String token,
  ) async {
    await shared.setString(MasterConst.VALUE_HOLDER__USER_FCMTOKEN, token);

    loadValueHolder();
  }

  Future<dynamic> getLoginFcmToken(
  ) async {
  return shared.getString(MasterConst.VALUE_HOLDER__USER_FCMTOKEN);
  }
  Future<dynamic> removeFcmToken() async {
    await shared.setString(MasterConst.VALUE_HOLDER__USER_FCMTOKEN, '');
    loadValueHolder();
  }

  Future<dynamic> removeHeaderToken() async {
    await shared.setString(MasterConst.VALUE_HOLDER__HEADER_TOKEN, '');
    loadValueHolder();
  }
}
