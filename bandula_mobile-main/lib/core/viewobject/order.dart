import 'common/master_object.dart';

class OrderData {
  OrderData({
    this.data,
  });

  List<Order>? data;

  OrderData fromMap(Map<String, dynamic> dynamicData) {
    return OrderData(
      data: Order().fromMapList(dynamicData['data']),
    );
  }
}

class OrderSingleData {
  OrderSingleData({
    this.status,
    this.data,
  });

  bool? status;
  Order? data;

  OrderSingleData fromMap(Map<String, dynamic> dynamicData) {
    return OrderSingleData(
        status: dynamicData['status'],
        data: Order().fromMap(dynamicData['data']));
  }
}

class OrderCreateSuccess {
  OrderCreateSuccess({
    this.status,
  });

  String? status;

  OrderCreateSuccess fromMap(Map<String, dynamic> dynamicData) {
    return OrderCreateSuccess(
      status: dynamicData['status'],
    );
  }
}

class Order extends MasterObject<Order> {
  Order({
    this.orderID,
    this.order,
  });
  String? orderID;
  OrderDa? order;

  @override
  String getPrimaryKey() {
    return orderID ?? '';
  }

  @override
  Order fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return Order(
        orderID: dynamicData['order_id'].toString(),
        order: OrderDa().fromMap(dynamicData['order_data']),
      );
    } else {
      return Order();
    }
  }

  @override
  Map<String, dynamic>? toMap(Order object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.orderID;
    // data['gameID'] = object.gameID;
    return data;
  }

  @override
  List<Order> fromMapList(List<dynamic> dynamicDataList) {
    final List<Order> subUserList = <Order>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Order> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Order? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}

class OrderDa {
  OrderDa({
    this.status,
    this.totalPrice,
    this.quantity,
    this.date,
  });

  String? status;
  String? totalPrice;
  String? quantity;
  String? date;

  OrderDa fromMap(Map<String, dynamic> dynamicData) {
    return OrderDa(
      status: dynamicData['status'],
      totalPrice: dynamicData['grand_total'].toString(),
      quantity: "",
      date: dynamicData['date'],
    );
  }

  Map<String, dynamic>? toMap(OrderDa object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = object.status.toString();
    data['grandtotal_price'] = object.totalPrice;
    data['quantity'] = object.quantity;
    data['date'] = object.date;
    return data;
  }
}
