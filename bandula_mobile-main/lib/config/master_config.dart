// ignore_for_file: constant_identifier_names

import '../core/db/common/master_data_source_manager.dart';
import '../core/viewobject/common/language.dart';

class MasterConfig {
  MasterConfig._();

  ///
  /// AppVersion
  /// For your app, you need to change according based on your app version

  static const String app_version = '1.0';

  ///
  /// API URL
  /// Change your backend url
  ///
  static const String core_url = 'https://bandulamobile.ecommyanmar.com/api';

  static const String app_url = '$core_url/';

  ////if demo url
  static bool isDemo = true;

  ///
  /// set showLog [True] to enable log
  ///
  static bool showLog = false;
  static void printLog(Object? object, {bool important = false}) {
    if (showLog & important) {
      // red
      print('\u001b[31m $object \u001b[0m');
    } else {
      // green
      print('\u001b[32m $object \u001b[0m');
    }
  }

  static final Language defaultLanguage =
      Language(languageCode: 'en', countryCode: 'US', name: 'English');
  static const String app_db_name = 'provider_test.db';

  /// For default language change, please check
  /// LanguageFragment for language code and country code
  /// ..............................................................
  /// Language             | Language Code     | Country Code
  /// ..............................................................
  /// "English"            | "en"              | "US"
  /// "Myanmar"            | "my"              | "MY"
  /// ..............................................................
  ///
  static final List<Language> psSupportedLanguageList = <Language>[
    Language(languageCode: 'my', countryCode: 'MY', name: 'Myanmar'),
    Language(languageCode: 'en', countryCode: 'US', name: 'English'),
  ];

  ///
  /// Animation Duration
  ///
  static const Duration animation_duration = Duration(milliseconds: 500);

  static const String default_font_family = 'Kanit';

  static DataConfiguration defaultDataConfig = DataConfiguration(
      dataSourceType: DataSourceType.SERVER_DIRECT,
      storePeriod: const Duration(days: 1));
}
