import 'package:equatable/equatable.dart';
import 'package:bandula/core/viewobject/common/master_object.dart';

// ignore: must_be_immutable
class NotiModel extends MasterObject<NotiModel> implements Equatable {
  int? id;
  String? title;
  String? message;
  String? status;
  String? date;

  NotiModel({
    this.id,
    this.title,
    this.message,
    this.date,
    this.status,
  });

  @override
  NotiModel fromMap(dynamicData) {
    return NotiModel(
      id: dynamicData["id"],
      title: dynamicData["title"],
      message: dynamicData["message"],
      status: dynamicData["status"],
      date: dynamicData["created_at"],
    );
  }

  @override
  List<NotiModel> fromMapList(List dynamicDataList) {
    List<NotiModel> list = [];
    for (var data in dynamicDataList) {
      list.add(NotiModel().fromMap(data));
    }
    return list;
  }

  @override
  String? getPrimaryKey() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(NotiModel object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<NotiModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [id, date, title, message];

  @override
  bool? get stringify => throw UnimplementedError();
}
