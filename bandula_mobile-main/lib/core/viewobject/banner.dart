import 'common/master_object.dart';
import 'package:quiver/core.dart';

class HomeBannerData {
  HomeBannerData({
    this.status,
    this.data,
  });
  String? status;
  List<HomeBanner>? data;

  HomeBannerData fromMap(Map<String, dynamic> dynamicData) {
    return HomeBannerData(
        status: dynamicData['status'],
        data: HomeBanner().fromMapList(dynamicData['data']));
  }
}

class HomeBanner extends MasterObject<HomeBanner> {
  HomeBanner({
    this.image,
  });

  String? image;

  @override
  bool operator ==(dynamic other) =>
      other is HomeBanner && image == other.image;

  @override
  int get hashCode {
    return hash2(image.hashCode, image.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return image.toString();
  }

  @override
  HomeBanner fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return HomeBanner(
        image: dynamicData,
      );
    } else {
      return HomeBanner(image: '');
    }
  }

  @override
  Map<String, dynamic>? toMap(HomeBanner object) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['image'] = object.image;
    return data;
  }

  @override
  List<HomeBanner> fromMapList(List<dynamic> dynamicDataList) {
    final List<HomeBanner> subUserList = <HomeBanner>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<HomeBanner> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (HomeBanner? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
