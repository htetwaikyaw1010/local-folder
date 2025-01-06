import 'common/master_object.dart';

class TownshipData {
  TownshipData({
    this.success,
    this.data,
  });
  String? success;
  List<Township>? data;
  TownshipData fromMap(Map<String, dynamic> dynamicData) {
    return TownshipData(
      success: dynamicData['status'],
      data: Township().fromMapList(dynamicData['data']),
    );
  }
}

class Township extends MasterObject<Township> {
  Township({
    this.townshipID,
    this.regionID,
    this.regionName,
    this.townshipName,
    this.cod,
    this.fees,
    this.duration,
    this.remark,
  });

  int? townshipID;
  int? regionID;
  String? regionName;
  String? townshipName;
  bool? cod;
  String? fees;
  String? duration;
  String? remark;

  @override
  String getPrimaryKey() {
    return townshipID.toString();
  }

  @override
  Township fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Township(
        townshipID: dynamicData['id'],
        regionID: dynamicData['region_id'],
        regionName: dynamicData['region_name'],
        townshipName: dynamicData['township'],
        cod: dynamicData['cod'],
        fees: dynamicData['fees'].toString(),
        duration: dynamicData['duration'].toString(),
        remark: dynamicData['remark'],
      );
    } else {
      return Township();
    }
  }

  @override
  Map<String, dynamic>? toMap(Township object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['township_id'] = object.townshipID;
    data['region_id'] = object.regionID;
    data['region_name'] = object.regionName;
    data['township_name'] = object.townshipName;
    data['cod'] = object.cod;
    data['fees'] = object.fees;
    data['duration'] = object.duration;
    data['remark'] = object.remark;
    return data;
  }

  @override
  List<Township> fromMapList(List<dynamic> dynamicDataList) {
    final List<Township> subUserList = <Township>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Township> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Township? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
