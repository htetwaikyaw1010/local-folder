import 'common/master_object.dart';

class CompCPUData {
  CompCPUData({
    this.status,
    this.data,
  });
  bool? status;
  List<CompCPU>? data;

  CompCPUData fromMap(Map<String, dynamic> dynamicData) {
    return CompCPUData(
      status: dynamicData['status'],
      data: CompCPU().fromMapList(dynamicData['data']),
    );
  }
}

class CompCPU extends MasterObject<CompCPU> {
  CompCPU({
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
  CompCPU fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return CompCPU(
        id: dynamicData["id"],
        name: dynamicData["name"],
      );
    } else {
      return CompCPU(id: 0);
    }
  }

  @override
  Map<String, dynamic>? toMap(CompCPU object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['name'] = object.name;
    return data;
  }

  @override
  List<CompCPU> fromMapList(List<dynamic> dynamicDataList) {
    final List<CompCPU> subUserList = <CompCPU>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CompCPU> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (CompCPU? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
