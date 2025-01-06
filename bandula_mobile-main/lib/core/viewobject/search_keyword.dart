import 'common/master_object.dart';

class SearchKeyword extends MasterObject<SearchKeyword> {
  SearchKeyword({
    this.id,
    this.searchKeyword,
  });

  String? id;
  String? searchKeyword;

  @override
  String getPrimaryKey() {
    return id.toString();
  }

  @override
  SearchKeyword fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return SearchKeyword(
        id: dynamicData['keyword_id'],
        searchKeyword: dynamicData['keyword'],
      );
    } else {
      return SearchKeyword();
    }
  }

  @override
  Map<String, dynamic>? toMap(SearchKeyword object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword_id'] = object.id;
    data['keyword'] = object.searchKeyword;
    return data;
  }

  @override
  List<SearchKeyword> fromMapList(List<dynamic> dynamicDataList) {
    final List<SearchKeyword> subUserList = <SearchKeyword>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<SearchKeyword> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (SearchKeyword? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
