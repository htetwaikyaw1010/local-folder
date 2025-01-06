import '../../../config/master_config.dart';
import '../../constant/master_constants.dart';
import '../../repository/Common/language_repository.dart';
import '../../viewobject/common/language.dart';
import '../../viewobject/holder/language_parameter_holder.dart';
import '../common/master_provider.dart';

class LanguageProvider extends MasterProvider<Language> {
  LanguageProvider({
    required LanguageRepository? repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
  }

  LanguageRepository? _repo;
  LanguageParameterHolder languageParameterHolder =
      LanguageParameterHolder().getDefaultParameterHolder();

  List<Language> _languageList = <Language>[];
  List<Language> get languageList => _languageList;

  List<String>? _excludedLanguageList = <String>[];
  List<String>? get excludedLanguageList => _excludedLanguageList;

  Language currentLanguage = MasterConfig.defaultLanguage;
  String currentCountryCode = '';
  String currentLanguageName = '';

  Future<dynamic> addLanguage(Language language) async {
    currentLanguage = language;
    return await _repo!.addLanguage(language);
  }

  Future<void> replaceUserChangesLocalLanguage(bool flag) async {
    await _repo!.replaceUserChangesLocalLanguage(flag);
  }

  Future<void> replaceExcludedLanguages(List<Language?> languages) async {
    await _repo!.replaceExcludedLanguages(languages);
  }

  bool isUserChangesLocalLanguage() {
    return _repo!.isUserChangesLocalLanguage();
  }

  Language getLanguage() {
    currentLanguage = _repo!.getLanguage();
    return currentLanguage;
  }

  List<dynamic> getLanguageList() {
    _languageList = MasterConfig.psSupportedLanguageList;
    return _languageList;
  }

  List<String>? getExcludedLanguageCodeList() {
    _excludedLanguageList = _repo!.getExcludedLanguageCodes();

    return _excludedLanguageList;
  }
}
