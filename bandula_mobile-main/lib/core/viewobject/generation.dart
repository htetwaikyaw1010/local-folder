import 'common/master_object.dart';

class GenerationData {
  GenerationData({
    this.status,
    this.data,
  });
  bool? status;
  List<Generation>? data;

  GenerationData fromMap(Map<String, dynamic> dynamicData) {
    return GenerationData(
      status: dynamicData['status'],
      data: Generation().fromMapList(dynamicData['data']),
    );
  }
}

class Generation extends MasterObject<Generation> {
  Generation({
    this.id,
    this.name,
  });

  int? id;
  String? name;

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
  Generation fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Generation(
        id: dynamicData["id"],
        name: dynamicData["name"],
      );
    } else {
      return Generation(id: 0);
    }
  }

  @override
  Map<String, dynamic>? toMap(Generation object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['name'] = object.name;
    return data;
  }

  @override
  List<Generation> fromMapList(List<dynamic> dynamicDataList) {
    final List<Generation> subUserList = <Generation>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Generation> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Generation? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
