import 'dart:async';
import 'package:sembast/sembast.dart';

import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../db/common/master_shared_preferences.dart';
import '../db/user_dao.dart';
import '../viewobject/api_status.dart';
import '../viewobject/login.dart';
import '../viewobject/user.dart';
import 'Common/master_repository.dart';

class UserRepository extends MasterRepository {
  UserRepository(
      {required MasterSharedPreferences sharedPreferences,
      required MasterApiService apiService,
      required UserDao userDao}) {
    shared = sharedPreferences;
    _apiService = apiService;
    _dao = userDao;
  }
  late MasterSharedPreferences shared;

  late MasterApiService _apiService;
  late UserDao _dao;
  final String _userPrimaryKey = 'id';
  final String mapKey = 'map_key';

  void sinkUserListStream(
      StreamController<MasterResource<List<User?>>>? userListStream,
      MasterResource<List<User?>> dataList) {
    if (userListStream != null) {
      userListStream.sink.add(dataList);
    }
  }

  void sinkUserDetailStream(
      StreamController<MasterResource<dynamic>>? userListStream,
      MasterResource<User?> data) {
    userListStream!.sink.add(data);
  }

  Future<dynamic> insert(User? user) async {
    return _dao.insert(_userPrimaryKey, user ?? User());
  }

  Future<dynamic> update(User user) async {
    return _dao.update(user);
  }

  Future<dynamic> delete(User user) async {
    return _dao.delete(user);
  }

  Future<dynamic> getUserFromDB(String loginUserId,
      StreamController<dynamic> userStream, MasterStatus status) async {
    final Finder finder =
        Finder(filter: Filter.equals(_userPrimaryKey, loginUserId));

    userStream.sink.add(await _dao.getOne(finder: finder, status: status));
  }

  Future<MasterResource<Login>> postUserLogin(
    String phone,
    String password,
    bool isConnectedToInternet,
    MasterStatus status,
    String fcmToken,
  ) async {

    final MasterResource<Login> resource = await _apiService.postUserLogin(
      phone,
      password,
      fcmToken,
    );

    if (resource.status == MasterStatus.SUCCESS) {
      await setLoginUserData(resource.data!);
    }
    return resource;
  }

  Future<MasterResource<Login>> postUserRegister(
    MasterStatus status, {
    required String name,
    required String password,
    required String phone,
    required String email,
    required String fcmToken,
  }) async {
    final MasterResource<Login> resource = await _apiService.postUserRegister(
      name: name,
      phone: phone,
      email: email,
      password: password,
      fcmToken: fcmToken,
    );
    if (resource.status == MasterStatus.SUCCESS) {
      await setLoginUserData(resource.data!);
    }
    return resource;
  }

  Future<dynamic> setLoginUserData(Login login) async {
    await MasterSharedPreferences.instance.setLoginUserData(
      login.token ?? '',
      login.name ?? '',
      login.id ?? '',
      login.phone ?? '',
      login.email ?? '',
    );
  }

  // User Logout
  Future<MasterResource<ApiStatus>> userLogout(
      String userToken, MasterStatus status,
      {bool isLoadFromServer = true,
      required Function callBackAfterLoginSuccess}) async {
    final MasterResource<ApiStatus> resource =
        await _apiService.postUserLogout(userToken);

    if (resource.status == MasterStatus.SUCCESS) {
      await MasterSharedPreferences.instance
          .setLoginUserData('', '', '', '', '');
      callBackAfterLoginSuccess(userToken);
      return resource;
    } else {
      final Completer<MasterResource<ApiStatus>> completer =
          Completer<MasterResource<ApiStatus>>();
      completer.complete(resource);
      return completer.future;
    }
  }

  // User Logout
  Future<MasterResource<ApiStatus>> changePassword(
      String token,
      String oldPassword,
      String newPassword,
      String confirmPassword,
      MasterStatus status,
      {bool isLoadFromServer = true}) async {
    final MasterResource<ApiStatus> resource = await _apiService
        .postChangePassword(token, oldPassword, newPassword, confirmPassword);

    if (resource.status == MasterStatus.SUCCESS) {
      return resource;
    } else {
      final Completer<MasterResource<ApiStatus>> completer =
          Completer<MasterResource<ApiStatus>>();
      completer.complete(resource);
      return completer.future;
    }
  }

  Future<MasterResource<ApiStatus>> deleteAccount(
    String token,
    String userID,
  ) async {
    final MasterResource<ApiStatus> resource =
        await _apiService.deleteAccount(token, userID);

    if (resource.status == MasterStatus.SUCCESS) {
      await MasterSharedPreferences.instance
          .setLoginUserData('', '', '', '', '');
      return resource;
    } else {
      final Completer<MasterResource<ApiStatus>> completer =
          Completer<MasterResource<ApiStatus>>();
      completer.complete(resource);
      return completer.future;
    }
  }
}
