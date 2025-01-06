import 'package:bandula/core/viewobject/common/master_object.dart';

class BlogData {
  String? status;
  List<Blog>? data;

  BlogData({this.status, this.data});

  BlogData fromMap(Map<String, dynamic> json) {
    return BlogData(
        status: json['status'], data: Blog().fromMapList(json['data']));
  }
}

class Blog extends MasterObject<Blog> {
  int? id;
  String? title;
  String? subTitle;
  String? description;
  String? photo;

  Blog({this.id, this.title, this.subTitle, this.description, this.photo});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    description = json['description'];
    photo = json['photo'];
  }

  @override
  Blog fromMap(dynamicData) {
    if (dynamicData != null) {
      return Blog(
        id: dynamicData["id"],
        title: dynamicData['title'],
        subTitle: dynamicData['subTitle'],
        description: dynamicData['description'],
      );
    } else {
      return Blog(id: 0);
    }
  }

  @override
  List<Blog> fromMapList(List<dynamic> dynamicDataList) {
    final List<Blog> superList = [];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        superList.add(Blog.fromJson(dynamicData));
      }
    }
    return superList;
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  @override
  Map<String, dynamic>? toMap(Blog object) {}

  @override
  List<Map<String, dynamic>?> toMapList(List<Blog> objectList) {
    throw UnimplementedError();
  }
}
