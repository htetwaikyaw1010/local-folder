import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:sembast/sembast.dart';
import 'package:bandula/core/db/cart_product_dao.dart';
import '../api/common/master_resource.dart';
import '../api/common/master_status.dart';
import '../api/master_api_service.dart';
import '../viewobject/api_status.dart';
import '../viewobject/cart_product.dart';
import '../viewobject/common/master_holder.dart';
import '../viewobject/holder/request_path_holder.dart';
import '../viewobject/order.dart';
import 'Common/master_repository.dart';

class CartRepository extends MasterRepository {
  CartRepository(
      {required MasterApiService apiService, required CartProductDao dao}) {
    _dao = dao;
    _apiService = apiService;
  }

  String primaryKey = 'id';
  late MasterApiService _apiService;

  late CartProductDao _dao;

  Future<dynamic> insert(CartProduct object) async {
    return _dao.insert(primaryKey, object);
  }

  Future<dynamic> update(CartProduct object) async {
    return _dao.update(object);
  }

  Future<dynamic> delete(CartProduct object) async {
    return _dao.delete(object);
  }

  Future<dynamic> get(String id) async {
    return _dao.getOne(finder: Finder(filter: Filter.byKey(id)));
  }

  @override
  Future<void> insertToDatabase({required dynamic obj}) async {
    await insert(obj);
  }

  Future<void> insertToDatabaseTest({required dynamic obj}) async {
    return _dao.insert(primaryKey, obj);
  }

  Future<void> updateToDatabase(
      {required StreamController<MasterResource<List<dynamic>>>
          streamController,
      required dynamic obj}) async {
    await update(obj);
  }

  @override
  Future<void> deleteFromDatabase(
      {required StreamController<MasterResource<List<dynamic>>>
          streamController,
      required dynamic obj}) async {
    await delete(obj);
  }

  @override
  Future<void> loadDataListFromDatabase({
    required StreamController<MasterResource<List<dynamic>>> streamController,
    MasterHolder<dynamic>? requestBodyHolder,
    RequestPathHolder? requestPathHolder,
  }) async {
    await startResourceSinkingForListFromDataBase(
        dao: _dao, streamController: streamController);
  }

  Future<MasterResource<OrderCreateSuccess>> createOrder({
    bool isCod = false,
    required String token,
    required String name,
    required String phone,
    required String address,
    required String paymentId,
    required List<CartProduct> carts,
    required String regionId,
    required String paymentName,
    required String fees,
    required String email,
    XFile? file,
  }) async {
    MasterResource<ApiStatus> resource =
        await _apiService.createCart(token: token, carts: carts);
    if (resource.data?.status == "success") {
      return await _apiService.createOrder(
        token: token,
        name: name,
        phone: phone,
        address: address,
        paymentId: paymentId,
        file: file!,
        regionId: regionId,
        paymentName: paymentName,
        fees: fees,
        email: email,
      );
    } else {
      return MasterResource<OrderCreateSuccess>(
        MasterStatus.ERROR,
        resource.message,
        null,
      );
    }
  }
}
