// ignore_for_file: constant_identifier_names

import 'package:sembast/sembast.dart';
import 'package:bandula/core/viewobject/search_keyword.dart';

import 'common/master_dao.dart';

class SearchKeywordDao extends MasterDao<SearchKeyword> {
  SearchKeywordDao._() {
    init(SearchKeyword());
  }

  static const String STORE_NAME = 'SearchKeyword';
  final String _primaryKey = 'keyword_id';

  // Singleton instance
  static final SearchKeywordDao _singleton = SearchKeywordDao._();

  // Singleton accessor
  static SearchKeywordDao get instance => _singleton;

  @override
  String? getPrimaryKey(SearchKeyword? object) {
    return object!.id;
  }

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  Filter getFilter(SearchKeyword? object) {
    return Filter.equals(_primaryKey, object!.id);
  }
}
