import 'common/master_object.dart';

class PaymentData {
  PaymentData({
    this.success,
    this.data,
  });
  String? success;
  List<Payment>? data;
  PaymentData fromMap(Map<String, dynamic> dynamicData) {
    return PaymentData(
      success: dynamicData['status'],
      data: Payment().fromMapList(dynamicData['data']),
    );
  }
}

class Payment extends MasterObject<Payment> {
  Payment({
    this.id,
    this.name,
    this.account,
    this.photo,
    this.phone,
    this.qr,
  });

  int? id;
  String? name;
  String? account;
  String? photo;
  String? phone;
  String? qr;

  @override
  String getPrimaryKey() {
    return id.toString();
  }

  @override
  Payment fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Payment(
        id: dynamicData['id'],
        name: dynamicData['payment_name'],
        account: dynamicData[''],
        photo: dynamicData['payment_image'],
        phone: dynamicData['payment_number'],
        qr: dynamicData['payment_qr'],
      );
    } else {
      return Payment();
    }
  }

  @override
  Map<String, dynamic>? toMap(Payment object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['region_id'] = object.id;
    data['name'] = object.name;
    data['account'] = object.account;
    data['photo'] = object.photo;

    return data;
  }

  @override
  List<Payment> fromMapList(List<dynamic> dynamicDataList) {
    final List<Payment> subUserList = <Payment>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Payment> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Payment? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
