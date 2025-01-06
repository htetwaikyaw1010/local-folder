import 'dart:async';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:bandula/firebase_options.dart';
import 'config/master_theme_data.dart';
import 'config/route/router.dart' as router;
import 'core/provider/cart/cart_provider.dart';
import 'core/provider/provider_dependencies.dart';
import 'core/repository/card_repository.dart';
import 'package:firebase_core/firebase_core.dart';

late BehaviorSubject<RemoteMessage> messageStreamController;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  {
    await Firebase.initializeApp();
  }

  AppLocalization.instance.ensureInitialized();

  runApp(const MainApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _AppState();
}

class _AppState extends State<MainApp> {
  Completer<ThemeData>? themeDataCompleter;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // init Color
    MasterColors.loadColor(context);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<AppLocalization>(create: (BuildContext context) {
          return AppLocalization.instance;
        }),
        ...providers,
      ],
      child: ThemeManager(
        
        defaultBrightnessPreference: BrightnessPreference.light,
        data: (Brightness brightness) {
          return themeData(ThemeData.light(),);
        },
        themedBuilder: (BuildContext context, ThemeState theme) {
          final CartRepository cartRepository =
              Provider.of<CartRepository>(context);

          return MultiProvider(
            providers: [
              ChangeNotifierProvider<CartProvider>(
                lazy: false,
                create: (_) {
                  CartProvider cartProvider =
                      CartProvider(repo: cartRepository);
                  cartProvider.loadDataListFromDatabase();
                  return cartProvider;
                },
              ),
            ],
            child: MaterialApp(
              
              debugShowCheckedModeBanner: false,
              title: '360 Mobile'.tr,
              theme: theme.themeData,
              initialRoute: '/',
              builder: BotToastInit(),
              onGenerateRoute: router.generateRoute,
              localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          );
        },
      ),
    );
  }
}

String fcm = '';
