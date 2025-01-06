// import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: avoid_print


import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import 'package:bandula/noti_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:bandula/firebase_options.dart';

class AppState {
  Future<void> initService() async {
    debugPrint('All services started...');
    
    await FirebaseMessaging.instance.requestPermission(
        sound: true, alert: true, badge: true, provisional: false);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      
      RemoteNotification? notification = message.notification;
      BotToast.showNotification(
          backgroundColor: Colors.white,
          leading: (_) => Image.asset(
                'assets/images/360profilenew.png',
                height: 40,
                width: 40,
              ),
          duration: const Duration(seconds: 2),
          title: (_) => Text(notification!.title!),
          subtitle: (_) => Text(notification!.body!));
    });

    debugPrint('All services Done...');
  }
}

class InitialAppBinding extends Bindings {
  @override
  void dependencies() {
    // await Get.putAsync(() => DbService().init());
    // await Get.putAsync(SettingsService()).init();
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  showFlutterNotification(message);
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: "@mipmap/ic_launcher",
        ),
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
