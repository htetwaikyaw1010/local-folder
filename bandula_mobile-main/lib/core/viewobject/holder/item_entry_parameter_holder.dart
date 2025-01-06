import '../common/master_holder.dart';

class ProductParameterHolder extends MasterHolder<ProductParameterHolder> {
  ProductParameterHolder(
      {this.productID, this.categoryID, this.name, this.unit, this.quantity});
  String? productID;
  String? categoryID;
  String? name;
  String? unit;
  String? quantity;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['order_id'] = productID;
    map['category_id'] = categoryID;
    map['name'] = name;
    map['unit'] = unit;
    map['quantity'] = quantity;
    return map;
  }

  @override
  ProductParameterHolder fromMap(dynamic dynamicData) {
    return ProductParameterHolder(
      productID: dynamicData['order_id'].toString(),
      categoryID: dynamicData['category_id'].toString(),
      name: dynamicData['name'],
      unit: dynamicData['unit'],
      quantity: dynamicData['quantity'],
    );
  }

  @override
  String getParamKey() {
    String key = '';

    if (productID != '') {
      key += productID!;
    }

    return key;
  }
}
