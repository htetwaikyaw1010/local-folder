import 'common/master_object.dart';

class OrderDetailsData {
  OrderDetailsData({
    this.status,
    this.data,
  });
  String? status;
  OrderDetails? data;

  OrderDetailsData fromMap(Map<String, dynamic> dynamicData) {
    return OrderDetailsData(
      status: dynamicData['status'],
      data: OrderDetails().fromMap(dynamicData['data'][0]),
    );
  }
}

class OrderDetails extends MasterObject<OrderDetails> {
  OrderDetails({
    this.id,
    this.uniId,
    this.address,
    this.customerName,
    this.date,
    this.paymentId,
    this.paymentMethod,
    this.phone,
    this.status,
    this.paymentPhoto,
    this.orderProduct,
    this.totalPrice,
    this.deliveryFee,
    this.totalProductQty,
    this.paymentNumber,
    this.refundSlip,
    this.refundMessage,
  });

  int? id;
  String? uniId;
  String? status;
  String? phone;
  String? address;
  String? customerName;
  int? paymentId;
  String? paymentMethod;
  String? date;
  String? paymentPhoto;
  String? deliveryFee;
  String? totalPrice;
  String? paymentNumber;
  String? refundSlip;
  String? refundMessage;
  int? totalProductQty;
  List<OrderProduct>? orderProduct;

  @override
  String getPrimaryKey() {
    return '';
  }

  @override
  OrderDetails fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return OrderDetails(
        id: dynamicData['id'],
        uniId: dynamicData['unique_id'].toString(),
        status: dynamicData['status'],
        phone: dynamicData['phone'],
        address: dynamicData['address'],
        customerName: dynamicData['customer_name'],
        date: dynamicData['date'],
        paymentId: dynamicData['payment_id'],
        paymentMethod: dynamicData['payment_method'],
        paymentPhoto: dynamicData['payment_photo'],
        totalPrice: dynamicData['grand-total'].toString() ?? '',
        deliveryFee: dynamicData['deli-fee'],
        refundSlip: dynamicData['refund_slip'] ?? "",
        paymentNumber: dynamicData['payment_number'],
        totalProductQty: dynamicData['total_product'],
        orderProduct: OrderProduct().fromMapList(
          dynamicData['order_product'],
        ),
        refundMessage: dynamicData['refund_message'],
      );
    } else {
      return OrderDetails();
    }
  }

  @override
  Map<String, dynamic>? toMap(OrderDetails object) {
    // if (object != null) {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['gameID'] = object.gameID;
    return data;
  }

  @override
  List<OrderDetails> fromMapList(List<dynamic> dynamicDataList) {
    final List<OrderDetails> subUserList = <OrderDetails>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderDetails> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (OrderDetails? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}

class OrderProduct extends MasterObject<OrderProduct> {
  int? id;
  int? orderId;
  int? quantity;
  int? productPrice;
  int? subPrice;
  int? grandTotal;
  String? date;
  OrderItem? product;
  OrderProduct({
    this.id,
    this.orderId,
    this.grandTotal,
    this.productPrice,
    this.quantity,
    this.subPrice,
    this.date,
    this.product,
  });

  @override
  OrderProduct fromMap(dynamicData) {
    return OrderProduct(
      id: dynamicData['id'],
      orderId: dynamicData['order_id'],
      quantity: dynamicData['quantity'],
      productPrice: dynamicData['product_price'],
      subPrice: dynamicData['sub_price'],
      date: dynamicData['created_at'],
      product: OrderItem().fromMap(dynamicData['product'][0]),
    );
  }

  @override
  List<OrderProduct> fromMapList(List dynamicDataList) {
    final List<OrderProduct> subUserList = <OrderProduct>[];

    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  String? getPrimaryKey() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(OrderProduct object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderProduct> objectList) {
    throw UnimplementedError();
  }
}

class OrderItem extends MasterObject<OrderItem> {
  int? id;
  String? name;
  int? price;
  int? stock;
  int? categoryId;
  String? color;
  String? detail;
  String? date;
  String? photo;

  OrderItem({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.categoryId,
    this.color,
    this.detail,
    this.date,
    this.photo,
  });
  @override
  OrderItem fromMap(dynamicData) {
    return OrderItem(
      id: dynamicData['id'],
      name: dynamicData['name'],
      price: dynamicData['price'],
      stock: dynamicData['stock'],
      categoryId: dynamicData['category_id'],
      color: dynamicData['color'],
      detail: dynamicData['detail'],
      date: dynamicData['created_at'],
      photo: dynamicData['photos'][0]['name'],
    );
  }

  @override
  List<OrderItem> fromMapList(List dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  String? getPrimaryKey() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(OrderItem object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderItem> objectList) {
    throw UnimplementedError();
  }
}
