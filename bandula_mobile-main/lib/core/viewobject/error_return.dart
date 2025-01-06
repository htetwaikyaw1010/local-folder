import 'package:quiver/core.dart';
import 'common/master_object.dart';

class ErrorReturn extends MasterObject<ErrorReturn> {
  ErrorReturn({
    // this.status,
    this.message,
  });
  // bool? status;
  String? message;

  @override
  bool operator ==(dynamic other) =>
      other is ErrorReturn && message == other.message;

  @override
  int get hashCode {
    return hash2(message.hashCode, message.hashCode);
  }

  @override
  String getPrimaryKey() {
    return message ?? '';
  }

  @override
  ErrorReturn fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      print(dynamicData['message']);
      return ErrorReturn(
        // status: dynamicData['status'],
        message: dynamicData['message'],
      );
    } else {
      return ErrorReturn(message: '');
    }
  }

  @override
  Map<String, dynamic>? toMap(ErrorReturn object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = object.message;
    return data;
  }

  @override
  List<ErrorReturn> fromMapList(List<dynamic> dynamicDataList) {
    final List<ErrorReturn> subUserList = <ErrorReturn>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ErrorReturn> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (ErrorReturn? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
