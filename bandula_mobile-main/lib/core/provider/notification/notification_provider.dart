import 'package:flutter/material.dart';
import 'package:bandula/core/api/common/master_resource.dart';
import 'package:bandula/core/constant/master_constants.dart';
import 'package:bandula/core/provider/common/master_provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/repository/noti_list_reposistory.dart';
import 'package:bandula/core/utils/ps_progress_dialog.dart';
import 'package:bandula/core/utils/utils.dart';
import 'package:bandula/core/viewobject/noti_model.dart';
import 'package:bandula/screen/common/dialog/error_dialog.dart';

class NotificationProvider extends MasterProvider<NotiModel> {
  NotificationProvider({
    required NotiListReposistory repo,
    int limit = 0,
  }) : super(
          repo,
          limit,
          subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION,
        ) {
    _notiListReposistory = repo;
  }
  NotiListReposistory? _notiListReposistory;

  MasterResource<List<NotiModel>> get notiList => super.dataList;

  NotiModel? detail;

  Future<dynamic> clearNoti(
      {required String token, required BuildContext context}) async {
    isLoading = true;
    if (notiList.data!.isNotEmpty) {
      if (await Utils.checkInternetConnectivity()) {
        // ignore: use_build_context_synchronously
        await MasterProgressDialog.showDialog(context);

        final MasterResource<dynamic> resourceUser =
            await _notiListReposistory!.clearAllNoti(
          token: token,
        );
        MasterProgressDialog.dismissDialog();

        // ignore: unnecessary_null_comparison
        if (resourceUser != null && resourceUser.data != null) {
          super.dataList.data?.clear();

          ///
          /// Success
          ///
          // }
          return "success";
        } else {
          // ignore: use_build_context_synchronously
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return const ErrorDialog(
                  message: "Error ",
                );
              });
        }
      } else {
        // ignore: use_build_context_synchronously
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'Error Dialog no internet'.tr,
            );
          },
        );
      }
    }
  }

  Future<dynamic> showNoti(
      {required String token,
      required BuildContext context,
      required int id}) async {
    isLoading = true;
    if (await Utils.checkInternetConnectivity()) {
      // ignore: use_build_context_synchronously
      await MasterProgressDialog.showDialog(context);

      final MasterResource<NotiModel> resourceUser =
          await _notiListReposistory!.showDetail(
        id,
        token,
      );
      MasterProgressDialog.dismissDialog();

      // ignore: unnecessary_null_comparison
      if (resourceUser != null && resourceUser.data != null) {
        ///
        /// Success
        detail = resourceUser.data;
        print("message is a : ${detail?.message ?? ""}");
        // }
        notifyListeners();
        return resourceUser;
      } else {
        // ignore: use_build_context_synchronously
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(
                message: "Error ",
              );
            });
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: 'Error Dialog no internet'.tr,
          );
        },
      );
    }
    notifyListeners();
  }
}
