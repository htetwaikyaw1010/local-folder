// ignore_for_file: constant_identifier_names

class MasterConst {
  MasterConst._();

  /// Language
  static const String LANGUAGE__LANGUAGE_CODE_KEY =
      'LANGUAGE__LANGUAGE_CODE_KEY';
  static const String LANGUAGE__COUNTRY_CODE_KEY = 'LANGUAGE__COUNTRY_CODE_KEY';
  static const String LANGUAGE__LANGUAGE_NAME_KEY =
      'LANGUAGE__LANGUAGE_NAME_KEY';
  static const String USER_CHANGE_LOCAL_LANGUAGE = 'USER_CHANGE_LOCAL_LANGUAGE';

  static const int REQUEST_CODE__HOME_FRAGMENT = 1001;
  static const int REQUEST_CODE__WISHLIST_FRAGMENT = 1002;
  static const int REQUEST_CODE__ORDER_FRAGMENT = 1003;
  static const int REQUEST_CODE__PROFILE_ACCOUNT_FRAGMENT = 1004;
  static const int REQUEST_CODE__NEWS_FRAGMENT = 1005;

  /// Subscrition Types
  static const String SINGLE_OBJECT_SUBSCRIPTION =
      'SINGLE_OBJECT_SUBSCRIPTION ';
  static const String LIST_OBJECT_SUBSCRIPTION = 'LIST_OBJECT_SUBSCRIPTION';
  static const String NO_SUBSCRIPTION = 'NO_SUBSCRIPTION';

  /// Error Codes
  static const String TOTALLY_NO_RECORD = 'TOTALLY_NO_RECORD';

  /// Device Info & Header Token
  static const String VALUE_HOLDER__PHONE_ID = 'VALUE_HOLDER__PHONE_ID';
  static const String VALUE_HOLDER__PHONE_MODEL_NAME =
      'VALUE_HOLDER__PHONE_MODEL_NAME';
  static const String VALUE_HOLDER__HEADER_TOKEN = 'VALUE_HOLDER__HEADER_TOKEN';

  /// USER
  static const String VALUE_HOLDER__USER_ID = 'USERID';
  static const String VALUE_HOLDER__USER_TOKEN = 'USER_TOKEN';
  static const String VALUE_HOLDER__USER_NAME = 'VALUE_HOLDER__USER_NAME';
  static const String VALUE_HOLDER__USER_EMAIL = 'VALUE_HOLDER__USER_EMAIL';
  static const String VALUE_HOLDER__USER_FCMTOKEN = 'VALUE_HOLDER__USER_FCMTOKEN';

  static const String VALUE_HOLDER__USER_CREDENTIAL =
      'VALUE_HOLDER__USER_CREDENTIAL';
  static const String VALUE_HOLDER__USER_PHOTO = 'VALUE_HOLDER__USER_PHOTO';

  /// Filtering Constants
  static const String FILTERING__SYMBOL = 'symbol'; // Don't Change
  static const String FILTERING__DESC = 'desc'; // Don't Change
  static const String FILTERING__ASC = 'asc'; // Don't Change
  /// Mobile Config
  static const String EXCLUDEDLANGUAGES = 'EXCLUDEDLANGUAGES';
}
