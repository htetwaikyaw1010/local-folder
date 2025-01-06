// ignore_for_file: use_build_context_synchronously

import 'package:bandula/core/provider/cart/cart_provider.dart';
import 'package:bandula/core/repository/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/screen/common/dialog/success_dialog.dart';
import 'package:provider/provider.dart';
import '../../../screen/common/dialog/error_dialog.dart';
import '../../api/common/master_resource.dart';
import '../../api/common/master_status.dart';
import '../../constant/master_constants.dart';
import '../../repository/user_repository.dart';
import '../../utils/ps_progress_dialog.dart';
import '../../utils/utils.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/login.dart';
import '../../viewobject/user.dart';
import '../common/master_provider.dart';

class UserProvider extends MasterProvider<User> {
  UserProvider({
    required UserRepository? repo,
    // required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.SINGLE_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  UserRepository? _repo;
  // MasterValueHolder? psValueHolder;
  User? holderUser;
  bool isCheckBoxSelect = true;
  bool isRememberMeChecked = false;
  String selectedCountryCode = '';
  String selectedCountryName = '';
  final MasterResource<ApiStatus> _apiStatus =
      MasterResource<ApiStatus>(MasterStatus.NOACTION, '', null);
  MasterResource<ApiStatus> get apiStatus => _apiStatus;

  Future<dynamic> getUserFromDB(String loginUserId) async {
    isLoading = true;

    await _repo!.getUserFromDB(loginUserId, super.dataStreamController!,
        MasterStatus.PROGRESS_LOADING);
  }

  // Future<dynamic> login(String credentials, String password) async {
  //   isLoading = true;

  //   await _repo!.login(credentials, password, super.dataStreamController!,
  //       MasterStatus.PROGRESS_LOADING);
  // }

  Future<dynamic> postUserLogin(
    BuildContext context,
    String phone,
    String password,
    Function callBackAfterLoginSuccess,
    String fcmToken,
  ) async {
    isLoading = true;
    if (await Utils.checkInternetConnectivity()) {
      await MasterProgressDialog.showDialog(context);

      final MasterResource<Login> resourceUser = await _repo!.postUserLogin(
        phone,
        password,
        isConnectedToInternet,
        MasterStatus.PROGRESS_LOADING,
        fcmToken,
      );

      print('response...${resourceUser.data}');

      // ignore: unnecessary_null_comparison
      if (resourceUser.data != null) {
        callBackAfterLoginSuccess(resourceUser.data!.token);
        // }
      } else {
        print('login fail...');
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: resourceUser.message,
              );
            });
            // MasterProgressDialog.dismissDialog();
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'Something Wrong',
            );
          },
        );
      // showDialog<dynamic>(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return ErrorDialog(
      //         message: 'error_dialog__no_internet'.tr,
      //       );
      //     });
    }
  }

  Future<dynamic> postUserRegister(BuildContext context,
      {required String name,
      required String password,
      required String email,
      required String phone,
      required String fcmToken,
      required Function callBackAfterLoginSuccess}) async {
    isLoading = true;

    if (await Utils.checkInternetConnectivity()) {
      await MasterProgressDialog.showDialog(context);
      final MasterResource<Login> resourceUser = await _repo!.postUserRegister(
        MasterStatus.PROGRESS_LOADING,
        name: name,
        phone: phone,
        email: email,
        password: password,
        fcmToken: fcmToken,
      );
      //MasterProgressDialog.dismissDialog();

      if (resourceUser.data != null) {
        callBackAfterLoginSuccess(resourceUser.data!.token);
      } else {

        

        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: resourceUser.message,
            );
          },
        );
        // MasterProgressDialog.dismissDialog();
      }
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'Something Wrong',
            );
          },
        );
        // MasterProgressDialog.dismissDialog();
      // showDialog<dynamic>(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return ErrorDialog(
      //       message: 'error_dialog__no_internet'.tr,
      //     );
      //   },
      // );
    }
  }

  // Log Out
  Future<dynamic> userLogout(
    BuildContext context,
    String token, {
    required Function callFuntion,
  }) async {
    isLoading = true;

    if (await Utils.checkInternetConnectivity()) {
      await MasterProgressDialog.showDialog(context);

      MasterResource<ApiStatus>? resource = await _repo!.userLogout(
        token,
        MasterStatus.PROGRESS_LOADING,
        callBackAfterLoginSuccess: callFuntion,
      );

      //MasterProgressDialog.dismissDialog();

      if (resource.data != null) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return SuccessDialog(
                message: resource.data!.message,
                onPressed: () {
                  callFuntion("user");
                },
              );
            });
      } else {
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: resource.message,
            );
          },
        );
      }
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'error_dialog__no_internet'.tr,
          );
        },
      );
    }
  }

  Future<dynamic> changePassword(BuildContext context, String token,
      String oldPassword, String newPassword, String confirmPassword) async {
    isLoading = true;

    if (await Utils.checkInternetConnectivity()) {
      await MasterProgressDialog.showDialog(context);
      MasterResource<ApiStatus>? resource = await _repo!.changePassword(
        token,
        oldPassword,
        newPassword,
        confirmPassword,
        MasterStatus.PROGRESS_LOADING,
      );
      MasterProgressDialog.dismissDialog();
      if (resource.data != null) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return SuccessDialog(
                message: resource.data!.message,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            });
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: resource.message,
              );
            });
      }
      return resource;
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'error_dialog__no_internet'.tr,
          );
        },
      );
    }
  }

  Future<dynamic> deleteAccount(
    BuildContext context,
    String token,
    String userID,
    Function callFuntion,
  ) async {
    isLoading = true;

    if (await Utils.checkInternetConnectivity()) {
      await MasterProgressDialog.showDialog(context);
      MasterResource<ApiStatus>? resource = await _repo!.deleteAccount(
        token,
        userID,
      );
      // MasterProgressDialog.dismissDialog();
      if (resource.data != null) {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return SuccessDialog(
                message: resource.data!.message,
                onPressed: () {
                  callFuntion("user");
                },
              );
            });
      } else {
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: resource.message,
              );
            });
      }
      return resource;
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'error_dialog__no_internet'.tr,
          );
        },
      );
    }
  }
}
