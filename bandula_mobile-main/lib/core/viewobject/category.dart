import 'common/master_object.dart';

class CategoryData {
  CategoryData({
    this.status,
    this.data,
  });
  String? status;
  List<Category>? data;

  CategoryData fromMap(Map<String, dynamic> dynamicData) {
    return CategoryData(
      status: dynamicData['status'],
      data: Category().fromMapList(dynamicData['data']),
    );
  }
}

class Category extends MasterObject<Category> {
  Category({
    this.id,
    this.name,
    this.image,
    // this.createdAt,
    // this.updatedAt,
  });

  int? id;
  String? name;
  String? image;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  // @override
  // bool operator ==(dynamic other) => other is HomeBanner && id == other.id;

  // @override
  // int get hashCode {
  //   return hash2(id.hashCode, id.hashCode);
  // }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Category fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Category(
        id: dynamicData["id"],
        name: dynamicData["name"],
        image: dynamicData["photo"],
        // createdAt: DateTime.parse(dynamicData["created_at"]),
        // updatedAt: DateTime.parse(dynamicData["updated_at"]),
      );
    } else {
      return Category(id: 0);
    }
  }

  @override
  Map<String, dynamic>? toMap(Category object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['name'] = object.name;
    data['photo'] = object.image;
    // data['created_at'] = object.createdAt.toString();
    // data['updated_at'] = object.updatedAt.toString();
    return data;
  }

  @override
  List<Category> fromMapList(List<dynamic> dynamicDataList) {
    final List<Category> subUserList = <Category>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Category> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Category? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
