import 'common/master_object.dart';

class User extends MasterObject<User> {
  User({this.userId, this.userName, this.credentials, this.photo});

  String? userId;
  String? userName;
  String? credentials;
  String? photo;

  @override
  String getPrimaryKey() {
    return userId ?? '';
  }

  @override
  User fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return User(
        userId: dynamicData['id'].toString(),
        userName: dynamicData['name'],
        credentials: dynamicData['credentials'],
        photo: dynamicData['photo'],
      );
    } else {
      return User();
    }
  }

  @override
  Map<String, dynamic>? toMap(User object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.userId;
    data['name'] = object.userName;
    data['credentials'] = object.credentials;
    data['photo'] = object.photo;

    return data;
  }

  @override
  List<User> fromMapList(List<dynamic> dynamicDataList) {
    final List<User> subUserList = <User>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<User> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (User? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
