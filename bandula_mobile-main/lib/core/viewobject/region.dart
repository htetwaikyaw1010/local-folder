import 'common/master_object.dart';

class RegionData {
  RegionData({
    this.success,
    this.data,
  });
  String? success;
  List<Region>? data;
  RegionData fromMap(Map<String, dynamic> dynamicData) {
    return RegionData(
      success: dynamicData['status'],
      data: Region().fromMapList(dynamicData['data']),
    );
  }
}

class Region extends MasterObject<Region> {
  Region({
    this.id,
    this.regionName,
  });

  int? id;
  String? regionName;

  @override
  String getPrimaryKey() {
    return id.toString();
  }

  @override
  Region fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Region(
        id: dynamicData['id'],
        regionName: dynamicData['name'],
      );
    } else {
      return Region();
    }
  }

  @override
  Map<String, dynamic>? toMap(Region object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['name'] = object.regionName;
    return data;
  }

  @override
  List<Region> fromMapList(List<dynamic> dynamicDataList) {
    final List<Region> subUserList = <Region>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Region> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Region? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
