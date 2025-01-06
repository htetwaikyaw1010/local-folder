import 'package:quiver/core.dart';

import 'common/master_object.dart';

class ProductData {
  ProductData({this.success, this.data, this.meta});
  String? success;
  List<Product>? data;
  Meta? meta;
  ProductData fromMap(Map<String, dynamic> dynamicData) {
    return ProductData(
        success: dynamicData['status'],
        data: Product().fromMapList(dynamicData['data']),
        meta: Meta().fromMap(dynamicData['meta']));
  }
}

class ProductSingleData {
  ProductSingleData({
    this.success,
    this.data,
  });
  String? success;
  Product? data;

  ProductSingleData fromMap(Map<String, dynamic> dynamicData) {
    return ProductSingleData(
      success: dynamicData['status'],
      data: Product().fromMap(dynamicData['data']),
    );
  }
}

class Product extends MasterObject<Product> {
  Product({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.preOrder,
    this.ram,
    this.storage,
    this.graphic,
    this.color,
    this.size,
    this.detail,
    this.categoryName,
    this.brandId,
    this.brandName,
    this.status,
    this.cpu,
    this.cpuID,
    this.generationID,
    this.generation,
    this.photos,
  });

  int? id;
  String? name;
  String? price;
  int? stock;
  int? preOrder;
  String? ram;
  String? storage;
  String? graphic;
  String? color;
  String? size;
  String? detail;
  String? categoryName;
  String? brandId;
  String? brandName;
  String? status;
  String? cpu;
  int? cpuID;
  int? generationID;
  String? generation;

  List<dynamic>? photos;

  @override
  bool operator ==(dynamic other) => other is Product && id == other.id;

  @override
  int get hashCode {
    return hash2(id.hashCode, id.hashCode);
  }

  @override
  String? getPrimaryKey() {
    return id.toString();
  }

  List<Product> checkDuplicate(List<Product> dataList) {
    final Map<int?, int?> idCache = <int?, int?>{};
    final List<Product> tmpList = <Product>[];
    for (int i = 0; i < dataList.length; i++) {
      if (idCache[dataList[i].id] == null) {
        tmpList.add(dataList[i]);
        idCache[dataList[i].id] = dataList[i].id;
      }
    }

    return tmpList;
  }

  @override
  Product fromMap(dynamic dynamicData) {
    return Product(
      id: dynamicData["id"],
      name: dynamicData["name"],
      preOrder: dynamicData["preorder"],
      stock: dynamicData["stock"],
      price: dynamicData["price"].toString(),
      color: dynamicData["color"],
      size: dynamicData["size"],
      detail: dynamicData["detail"],
      categoryName: dynamicData["category_name"],
      brandId: dynamicData["brand_id"].toString(),
      brandName: dynamicData["brand_name"],
      status: dynamicData["status"],
      photos: dynamicData["photos"],
    );
  }

  @override
  Map<String, dynamic>? toMap(Product object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data["name"] = object.name;
    data["stock"] = object.stock;
    data["price"] = object.price;
    data["price"] = object.price;
    data['color'] = object.color;
    data['size'] = object.size;
    data['detail'] = object.detail;
    data['category_name'] = object.categoryName;
    data['brand_name'] = object.brandName;
    data['status'] = object.status;
    data['photos'] = object.photos;
    data['preorder'] = object.preOrder;
    return data;
  }

  @override
  List<Product> fromMapList(List<dynamic> dynamicDataList) {
    // final List<Product> subUserList = <Product>[];
    // // print('length :${dynamicDataList.length}');
    // for (dynamic dynamicData in dynamicDataList) {
    //   // print(dynamicData['id']);
    //   subUserList.add(fromMap(dynamicData));
    // }
    List<Product> prolist = List<Product>.from(dynamicDataList.map((x) {
      return fromMap(x);
    }));
    return prolist;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Product> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (Product? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}

// class CompCPU {
//   CompCPU({
//     required this.id,
//     required this.name,
//     required this.photo,
//     required this.gen,
//   });

//   int id;
//   String name;
//   String photo;
//   String gen;

//   factory CompCPU.fromJson(Map<String, dynamic> json) => CompCPU(
//         id: json["id"],
//         name: json["name"],
//         photo: json["photo"],
//         gen: json["gen"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "photo": photo,
//         "gen": gen,
//       };
// }

// class CompCPU extends MasterObject<Product> {
//   CompCPU({
//     this.id,
//     this.name,
//     this.photo,
//     this.gen,
//   });

//   int? id;
//   String? name;
//   String? photo;
//   String? gen;

//   CompCPU fromMap(Map<String, dynamic> dynamicData) {
//     return CompCPU(
//       id: dynamicData["id"],
//       name: dynamicData["name"],
//       photo: dynamicData["photo"],
//       gen: dynamicData["gen"],
//     );
//   }

//   Map<String, dynamic>? toMap(dynamic object) {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (object != null) {
//       data['id'] = object.id;
//       data['name'] = object.name;
//       data['photo'] = object.photo;
//       data['gen'] = object.gen;
//       return data;
//     } else {
//       return null;
//     }
//   }
// }

class Meta {
  Meta({
    this.totalProduct,
    this.currentPage,
    this.lastPage,
    this.hasMorePage,
  });

  int? totalProduct;
  int? currentPage;
  int? lastPage;
  bool? hasMorePage;

  Meta fromMap(Map<String, dynamic> dynamicData) {
    return Meta(
      totalProduct: dynamicData["total_product"],
      currentPage: dynamicData["current_page"],
      lastPage: dynamicData["last_page"],
      hasMorePage: dynamicData["has_more_page"],
    );
  }
}
