// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bandula/core/viewobject/cart_product.dart';
import '../../../config/master_config.dart';
import '../../../screen/common/dialog/error_dialog.dart';
import '../../api/common/master_resource.dart';
import '../../constant/master_constants.dart';
import '../../repository/card_repository.dart';
import '../../utils/ps_progress_dialog.dart';
import '../../viewobject/order.dart';
import '../common/master_provider.dart';

class CartProvider extends MasterProvider<CartProduct> {
  CartProvider({required CartRepository repo, int limit = 0})
      : super(repo, limit,
            subscriptionType: MasterConst.LIST_OBJECT_SUBSCRIPTION) {
    _repo = repo;
    regionController.text = 'Please Select Region';
    townshipController.text = 'Please Select Township';
  }

  late CartRepository _repo;
  List<CartProduct> get cardProductList => super.dataList.data ?? [];
  double totalCost = 0;

  TextEditingController regionController = TextEditingController();
  TextEditingController townshipController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Future<dynamic> addToDatabase(dynamic obj) async {
    await _repo.insertToDatabase(
        obj: CartProduct(
            id: obj.product.id,
            cost: obj.cost,
            product: obj.product,
            quantity: obj.quantity));
    dataList.data?.clear();
    await _repo.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }

  @override
  Future<dynamic> deleteFromDatabase(dynamic obj) async {
    await _repo.deleteFromDatabase(
        streamController: dataListStreamController!, obj: obj);
    totalCost -= obj.cost;
    dataList.data?.clear();
    await _repo.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }

  Future<dynamic> clearAllFromDatabase() async {
    if (dataLength > 0) {
      for (CartProduct da in dataList.data!) {
        await _repo.deleteFromDatabase(
            streamController: dataListStreamController!, obj: da);
      }
    }
    totalCost = 0;
    dataList.data?.clear();
    await _repo.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }

  Future<dynamic> updateToDatabase(dynamic obj) async {
    await _repo.updateToDatabase(
        streamController: dataListStreamController!, obj: obj);
    notifyListeners();
  }

  Future<void> createOrder(
    BuildContext context,
    Function callBackAfterSuccess, {
    bool isCod = false,
    required String token,
    required String name,
    required String userid,
    required String phone,
    required String address,
    String? paymentId,
    required List<CartProduct> carts,
    required String regionId,
    required String paymentName,
    required String fees,
    required String email,
    XFile? file,
  }) async {
    await MasterProgressDialog.showDialog(context);

    MasterResource<OrderCreateSuccess> resource = await _repo.createOrder(
      isCod: isCod,
      token: token,
      name: name,
      phone: phone,
      address: address,
      paymentId: paymentId ?? '',
      carts: carts,
      file: file,
      regionId: regionId,
      paymentName: paymentName,
      fees: fees,
      email: email,
    );
    MasterProgressDialog.dismissDialog();

    if (resource.data?.status == "success") {
      await clearAllFromDatabase();
      callBackAfterSuccess();
    } else {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            message: resource.message,
          );
        },
      );
    }
  }

  @override
  Future<dynamic> loadDataListFromDatabase({
    bool reset = false,
  }) async {
    if (reset) {
      MasterConfig.printLog('🔄 Data Refresh in ($runtimeType) 🔄');
      dataList.data?.clear();
      dataList.data?.length = 0;
    }
    await _repo.loadDataListFromDatabase(
        streamController: dataListStreamController!);
  }
}
