import 'dart:async';
import 'package:flutter/material.dart';

import '../../../config/master_config.dart';
import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../db/common/master_data_source_manager.dart';
import '../../db/common/master_shared_preferences.dart';
import '../../db/language_dao.dart';
import '../../viewobject/common/language.dart';
import '../../viewobject/common/language_value_holder.dart';
import '../../viewobject/common/master_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import 'master_repository.dart';

class LanguageRepository extends MasterRepository {
  LanguageRepository(
      {required MasterSharedPreferences sharedPreferences,
      required LanguageDao languageDao}) {
    _masterSharedPreferences = sharedPreferences;
    _languageDao = languageDao;
  }

  final StreamController<LanguageValueHolder> _valueController =
      StreamController<LanguageValueHolder>();
  // Stream<PsLanguageValueHolder> get psValueHolder => _valueController.stream;

  late MasterSharedPreferences _masterSharedPreferences;
  late LanguageDao _languageDao;
  final String _primaryKey = 'id';

  Future<dynamic> insert(Language language) async {
    return _languageDao.insert(_primaryKey, language);
  }

  Future<dynamic> update(Language noti) async {
    return _languageDao.update(noti);
  }

  Future<dynamic> delete(Language noti) async {
    return _languageDao.delete(noti);
  }

  @override
  Future<void> loadDataList({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
    required DataConfiguration dataConfig,
  }) async {
    // final Finder finder =
    //     Finder(filter: Filter.equals('enable', MasterConst.ONE));
    // startResourceSinkingForList(
    //     dao: _languageDao,
    //     streamController: streamController,
    //     dataConfig: dataConfig,
    //     serverRequestCallback: () {});
  }

  void loadLanguageValueHolder() {
    final String? languageCodeKey = _masterSharedPreferences.shared
        .getString(MasterConst.LANGUAGE__LANGUAGE_CODE_KEY);
    final String? countryCodeKey = _masterSharedPreferences.shared
        .getString(MasterConst.LANGUAGE__COUNTRY_CODE_KEY);
    final String? languageNameKey = _masterSharedPreferences.shared
        .getString(MasterConst.LANGUAGE__LANGUAGE_NAME_KEY);

    _valueController.add(LanguageValueHolder(
      languageCode: languageCodeKey,
      countryCode: countryCodeKey,
      name: languageNameKey,
    ));
  }

  Future<void> addLanguage(Language language) async {
    await _masterSharedPreferences.shared.setString(
        MasterConst.LANGUAGE__LANGUAGE_CODE_KEY, language.languageCode!);
    await _masterSharedPreferences.shared.setString(
        MasterConst.LANGUAGE__COUNTRY_CODE_KEY, language.countryCode!);
    await _masterSharedPreferences.shared.setString(
        MasterConst.LANGUAGE__LANGUAGE_NAME_KEY, language.name ?? '');
    await _masterSharedPreferences.shared.setString('locale',
        Locale(language.languageCode!, language.countryCode).toString());
    loadLanguageValueHolder();
  }

  Future<dynamic> replaceUserChangesLocalLanguage(bool flag) async {
    await _masterSharedPreferences.shared
        .setBool(MasterConst.USER_CHANGE_LOCAL_LANGUAGE, flag);
    loadLanguageValueHolder();
  }

  bool isUserChangesLocalLanguage() {
    return _masterSharedPreferences.shared
            .getBool(MasterConst.USER_CHANGE_LOCAL_LANGUAGE) ??
        false;
  }

  Future<dynamic> replaceExcludedLanguages(List<Language?> languages) async {
    final List<String> languageCodeList = <String>[];
    for (Language? language in languages) {
      languageCodeList.add(language!.languageCode ?? '');
    }
    await _masterSharedPreferences.shared
        .setStringList(MasterConst.EXCLUDEDLANGUAGES, languageCodeList);
    loadLanguageValueHolder();
  }

  List<String>? getExcludedLanguageCodes() {
    return _masterSharedPreferences.shared
            .getStringList(MasterConst.EXCLUDEDLANGUAGES) ??
        <String>[];
  }

  Language getLanguage() {
    final String? languageCode = _masterSharedPreferences.shared
            .getString(MasterConst.LANGUAGE__LANGUAGE_CODE_KEY) ??
        MasterConfig.defaultLanguage.languageCode;
    final String? countryCode = _masterSharedPreferences.shared
            .getString(MasterConst.LANGUAGE__COUNTRY_CODE_KEY) ??
        MasterConfig.defaultLanguage.countryCode;
    final String? languageName = _masterSharedPreferences.shared
            .getString(MasterConst.LANGUAGE__LANGUAGE_NAME_KEY) ??
        MasterConfig.defaultLanguage.name;

    return Language(
        languageCode: languageCode,
        countryCode: countryCode,
        name: languageName);
  }
}
