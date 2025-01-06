import 'package:quiver/core.dart';
import 'package:bandula/core/viewobject/product.dart';

import 'common/master_object.dart';

class CartProduct extends MasterObject<CartProduct> {
  CartProduct({this.id, this.product, this.quantity, this.cost});

  int? id;
  Product? product;
  int? quantity;
  double? cost;

  @override
  bool operator ==(dynamic other) => other is CartProduct && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  List<CartProduct> checkDuplicate(List<CartProduct> dataList) {
    final Map<int?, int?> idCache = <int?, int?>{};
    final List<CartProduct> tmpList = <CartProduct>[];
    for (int i = 0; i < dataList.length; i++) {
      if (idCache[dataList[i].id] == null) {
        tmpList.add(dataList[i]);
        idCache[dataList[i].id] = dataList[i].id;
      }
    }

    return tmpList;
  }

  @override
  CartProduct fromMap(dynamic dynamicData) {
    return CartProduct(
        id: dynamicData["id"],
        quantity: dynamicData["quantity"],
        product: Product().fromMap(dynamicData["product"]),
        cost: double.parse(dynamicData["cost"].toString()));
  }

  @override
  Map<String, dynamic>? toMap(CartProduct object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data["quantity"] = object.quantity ?? 1;
    data["product"] = Product().toMap(object.product!);
    data["cost"] = object.cost;
    return data;
  }

  @override
  List<CartProduct> fromMapList(List<dynamic> dynamicDataList) {
    List<CartProduct> prolist = List<CartProduct>.from(dynamicDataList.map((x) {
      return fromMap(x);
    }));
    return prolist;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CartProduct> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (CartProduct? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
