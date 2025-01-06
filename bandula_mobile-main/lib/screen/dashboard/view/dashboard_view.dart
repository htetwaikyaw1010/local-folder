import 'dart:async';

import 'package:bandula/core/provider/user/user_provider.dart';
import 'package:bandula/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bandula/config/master_config.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:provider/provider.dart';

import '../../../config/master_colors.dart';
import '../../../core/constant/master_constants.dart';
import '../../common/dialog/confirm_dialog_view.dart';
import '../widget/app_bar/appbar.dart';
import '../widget/body/dashboard_body_widget.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:bandula/app_state.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import 'package:bandula/noti_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    Key? key,
  }) : super(key: key);
  @override
  State<DashboardView> createState() => _HomeViewState();
}

class _HomeViewState extends State<DashboardView>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  MasterValueHolder? valueHolder;
  late UserProvider userProvider;
  late Animation<double> animation;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController animationController;
  late AnimationController animationControllerForFab;
  String appBarTitleName = '360 Mobile Center';

  void changeAppBarTitle(String categoryName) {
    appBarTitleName = categoryName;
  }

  int? _currentIndex = MasterConst.REQUEST_CODE__HOME_FRAGMENT;

  Future<void> updateSelectedIndexWithAnimation(
      String? title, int? index) async {
    await animationController.reverse().then<dynamic>((void data) {
      if (!mounted) {
        return;
      }

      setState(() {
        appBarTitleName = title!;
        // appBarTitle = title;
        _currentIndex = index;
      });
    });
  }

  void updateSelectedIndexAndAppBarTitle(String? title, int? index) {
    setState(() {
      appBarTitleName = title!;
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        duration: MasterConfig.animation_duration, vsync: this);

    animationControllerForFab = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 1);

    super.initState();
    WidgetsBinding.instance.addObserver(this);

    
  }

  final notiVM = Get.put(NotiController());
  Future<void> initFirebase(String token, int id) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      notiVM.showBadge.value = true;
      notiVM.callNoti(token, id);
      showFlutterNotification(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<MasterValueHolder>(context);
    if (Utils.isLogined(valueHolder)) {
      initFirebase(valueHolder?.loginUserToken ?? '',
          int.parse(valueHolder?.loginUserId ?? ''));
      notiVM.callNoti(valueHolder?.loginUserToken ?? '',
          int.parse(valueHolder?.loginUserId ?? ''));
    }
    Future<bool> onWillPop() {
      return showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialogView(
              title: 'Confirm',
              description: 'Are you sure You want To Quit',
              leftButtonText: 'Cancel',
              rightButtonText: 'Ok',
              onAgreeTap: () {
                Navigator.pop(context, true);
              },
            );
          }).then((dynamic value) {
        if (value) {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        }
        return value;
      });
    }

    Future<void> updateSelectedIndex(int index) async {
      setState(() {
        _currentIndex = index;

        print('index is...$_currentIndex');
      });
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        appBar: DashboardAppBar(appBarTitleName: appBarTitleName, isAccount: _currentIndex == 4 ? true : false, index: '$_currentIndex',),
        body: DashboardBodyWidget(
          currentIndex: _currentIndex!,
          updateSelectedIndex: updateSelectedIndex,
          updateSelectedIndexAndAppBarTitle: updateSelectedIndexAndAppBarTitle,
          updateSelectedIndexWithAnimation: updateSelectedIndexWithAnimation,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(254, 242, 0, 1),
          currentIndex: getBottonNavigationIndex(_currentIndex),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          unselectedItemColor: MasterColors.black,
          selectedItemColor: MasterColors.mainColor,
          selectedLabelStyle: const TextStyle(
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w400),
          unselectedLabelStyle: const TextStyle(
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w400),
          onTap: (int index) {
            final dynamic returnValue =
                getIndexFromBottonNavigationIndex(index);
            updateSelectedIndexWithAnimation(returnValue[0], returnValue[1]);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.home_outlined,
                size: 24,
              ),
              icon: const Icon(
                Icons.home_outlined,
                size: 24,
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.favorite_border,
                size: 24,
              ),
              icon: const Icon(Icons.favorite_border),
              label: 'wishlist'.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.shopping_bag_outlined,
                size: 24,
              ),
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 24,
              ),
              label: 'order'.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.message_outlined,
                size: 24,
              ),
              icon: const Icon(
                Icons.message_outlined,
                size: 24,
              ),
              label: 'news'.tr,
            ),
            BottomNavigationBarItem(
              activeIcon: const Icon(
                Icons.person_3_outlined,
                size: 24,
              ),
              icon: const Icon(Icons.person_3_outlined, size: 24),
              label: 'account'.tr,
            ),
          ],
        ),
        //floatingActionButton: const FloatingMessengerWidget(),
      ),
    );
  }

  int getBottonNavigationIndex(int? param) {
    int index = 0;
    switch (param) {
      case MasterConst.REQUEST_CODE__HOME_FRAGMENT:
        index = 0;
        break;
      case MasterConst.REQUEST_CODE__WISHLIST_FRAGMENT:
        index = 1;
        break;
      case MasterConst.REQUEST_CODE__ORDER_FRAGMENT:
        index = 2;
        break;
      case MasterConst.REQUEST_CODE__PROFILE_ACCOUNT_FRAGMENT:
        index = 4;
        break;
      case MasterConst.REQUEST_CODE__NEWS_FRAGMENT:
        index = 3;
      default:
        index = 0;
        break;
    }
    return index;
  }

  dynamic getIndexFromBottonNavigationIndex(int param) {
    int index = MasterConst.REQUEST_CODE__HOME_FRAGMENT;
    String title;
    switch (param) {
      case 0:
        index = MasterConst.REQUEST_CODE__HOME_FRAGMENT;
        title = '360 Mobile Center';
        appBarTitleName = title;
        break;
      case 1:
        index = MasterConst.REQUEST_CODE__WISHLIST_FRAGMENT;
        title = 'wishlist'.tr;
        appBarTitleName = title;
        break;
      case 2:
        index = MasterConst.REQUEST_CODE__ORDER_FRAGMENT;
        title = 'order'.tr;
        appBarTitleName = title;
        break;
      case 3:
        index = MasterConst.REQUEST_CODE__NEWS_FRAGMENT;
        title = "news".tr;
        appBarTitleName = title;
        break;
      case 4:
        index = MasterConst.REQUEST_CODE__PROFILE_ACCOUNT_FRAGMENT;
        title = 'account'.tr;
        appBarTitleName = title;
        break;

      default:
        index = 0;
        title = '360 Mobile Center';
        appBarTitleName = title;
        break;
    }
    return <dynamic>[title, index];
  }
}
