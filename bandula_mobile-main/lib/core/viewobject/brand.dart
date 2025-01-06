import 'common/master_object.dart';

class BrandData {
  BrandData({
    this.status,
    this.data,
  });
  String? status;
  List<Brand>? data;

  BrandData fromMap(Map<String, dynamic> dynamicData) {
    return BrandData(
      status: dynamicData['status'],
      data: Brand().fromMapList(dynamicData['data']['brands']),
    );
  }
}

class Brand extends MasterObject<Brand> {
  Brand({
    this.id,
    this.name,
    this.photo,
  });

  int? id;
  String? name;
  String? photo;

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
  Brand fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Brand(
        id: dynamicData["id"],
        name: dynamicData["name"],
        photo: dynamicData["photo"],
      );
    } else {
      return Brand(id: 0);
    }
  }

  @override
  Map<String, dynamic>? toMap(Brand object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['name'] = object.name;
    data['image'] = object.photo;
    return data;
  }

  @override
  List<Brand> fromMapList(List<dynamic> dynamicDataList) {
    final List<Brand> subUserList = <Brand>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Brand> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Brand? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
