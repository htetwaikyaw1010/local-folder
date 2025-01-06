import 'package:bandula/core/repository/search_keyword_repository.dart';
import 'package:bandula/core/viewobject/search_keyword.dart';

import '../../constant/master_constants.dart';
import '../common/master_provider.dart';

class SearchKeywordProvider extends MasterProvider<SearchKeyword> {
  SearchKeywordProvider({
    required SearchKeywordRepository repo,
    int limit = 0,
  }) : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    // _repo = repo;
  }

  // SearchKeywordRepository? _repo;
  List<SearchKeyword> get searchKeywordList => super.dataList.data ?? [];
}
