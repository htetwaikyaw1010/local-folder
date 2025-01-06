import 'dart:io';

import 'package:bandula/noti_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

import '../constant/master_constants.dart';
import '../viewobject/common/master_value_holder.dart';
import '../viewobject/product.dart';

mixin Utils {
  static bool isReachChatView = false;
  static bool isNotiFromToolbar = false;

  static bool? checkEmailFormat(String email) {
    bool? emailFormat;
    if (email != '') {
      emailFormat = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
    }
    return emailFormat;
  }

  static DateTime? previous;
  static void masterPrint(String? msg) {
    final DateTime now = DateTime.now();
    if (previous == null) {
      previous = now;
    } else {
      previous = now;
    }
  }

  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }

  static bool? checkColorCodeFormat(String code) {
    bool? codeFormat;
    if (code != '') {
      codeFormat = RegExp(r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$').hasMatch(code);
    }
    return codeFormat;
  }

  static Color hexToColor(String code, Color defaultColor) {
    if (code != '' && checkColorCodeFormat(code)!) {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      return defaultColor;
    }
  }

  static Brightness getBrightnessForAppBar(BuildContext context) {
    if (Platform.isAndroid) {
      return Utils.isLightMode(context) ? Brightness.dark : Brightness.light;
    } else {
      return Theme.of(context).brightness;
    }
  }

  static String convertColorToString(Color? color) {
    String convertedColorString = '';

    String colorString = color.toString().toUpperCase();

    colorString = colorString.replaceAll(')', '');

    convertedColorString = colorString.substring(colorString.length - 6);

    return '#$convertedColorString';
  }

  static Future<bool> checkInternetConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // print('Mobile');
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi) ) {
      // print('Wifi');
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return false;
    }
  }

  static bool isLogined(MasterValueHolder? valueHolder) {
    final _notiController = Get.put(NotiController());
    print("token : ${valueHolder?.loginUserToken ?? ""}");
    if (valueHolder!.loginUserToken == null ||
        valueHolder.loginUserToken!.isEmpty) {
      print("token : absent");
      _notiController.isFetchable.value = false;
      return false;
    } else {
      print("token present : ${valueHolder!.loginUserToken}");
      _notiController.isFetchable.value = true;
      return true;
    }
  }

  // static bool isLoginUserEmpty(MasterValueHolder? psValueHolder) {
  //   return psValueHolder == null ||
  //       psValueHolder.loginUserId == null ||
  //       psValueHolder.loginUserId == '';
  // }

  ///
  /// Check Current Index for Dashboard Fragment
  ///
  static bool showHomeDashboardView(int? currentIndex) =>
      currentIndex == MasterConst.REQUEST_CODE__HOME_FRAGMENT;

  static Color statusColor(String text) {
    if (text == 'pending' || text == 'Pending') {
      return Colors.yellow[200]!;
    } else if (text == 'confirmed' || text == 'Confirmed') {
      return Colors.green[200]!;
    } else if (text == 'complete' || text == 'Complete') {
      return Colors.green;
    } else if (text == 'reject' || text == 'Reject') {
      return Colors.red;
    } else if (text == 'refund' || text == 'Refund') {
      return Colors.red;
    }
    return Colors.cyan;
  }

  static bool isFavouritedProduct(Product data, List<Product> dataList) {
    for (Product pro in dataList) {
      if (pro.id == data.id) {
        return true;
      }
    }
    return false;
  }

  ///
  ///End
  ///
}
