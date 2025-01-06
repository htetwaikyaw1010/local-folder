import 'dart:async';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/noti_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/user/user_provider.dart';

import '../../../app_state.dart';
import '../../../config/route/route_paths.dart';
// import '../../../core/utils/utils.dart';
import '../../../core/viewobject/common/master_value_holder.dart';

class AppLoadingView extends StatefulWidget {
  const AppLoadingView({super.key});

  @override
  State<AppLoadingView> createState() => _AppLoadingViewState();
}

class _AppLoadingViewState extends State<AppLoadingView>
    with TickerProviderStateMixin {
  MasterValueHolder? valueHolder;

  late NavigatorState navigator;
  late AnimationController controller;
  late Animation<double> animation;

  MasterValueHolder? valueHolders;
  late UserProvider userProvider;
  final _notiController = Get.put(NotiController());
  @override
  void initState()  {
     AppState().initService();
     FirebaseMessaging fcm =  FirebaseMessaging.instance;
     fcm.getToken().then((value) {
      print("firebase token -> $value");
      _notiController.fcm.value = value ?? '';
    });
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // messageStreamController = BehaviorSubject<RemoteMessage>();
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    Timer(const Duration(seconds: 2), () async {
      await Navigator.pushReplacementNamed(
          context,
          // Utils.isLogined(valueHolder)
          // ?
          RoutePaths.home
          // : RoutePaths.loginOrSignup,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<MasterValueHolder?>(context);

    return Scaffold(
      backgroundColor: MasterColors.lMainColor,
      // appBar: AppBar(
      //   backgroundColor: Color.fromRGBO(254, 242, 0, 1),
      //   elevation: 0,
      //   systemOverlayStyle: SystemUiOverlayStyle(
      //     statusBarColor: Color.fromRGBO(254, 242, 0, 1),
      //   ),
      // ),
      body: Center(
        child: Image.asset(
          "assets/images/360profile.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
